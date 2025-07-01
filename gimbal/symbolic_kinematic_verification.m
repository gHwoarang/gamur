clc
clear all

syms psi theta gamma psi_dot theta_dot gamma_dot alpha1 alpha2 alpha3

% Degrees in radian

Rot_e_1 = rotate_Z_so3(psi);            % In accordance with 56
Rot_1_2 = rotate_Y_so3(theta);          % In accordance with 56
Rot_2_b = rotate_X_so3(gamma);          % In accordance with 56

Rot_1_e = transpose(rotate_Z_so3(psi));            % In accordance with 56
Rot_2_1 = transpose(rotate_Y_so3(theta));          % In accordance with 56
Rot_b_2 = transpose(rotate_X_so3(gamma));          % In accordance with 56

Rot_e_b = Rot_e_1*Rot_1_2*Rot_2_b;      % In accordance with 56



T_inv_calc = [gamma_dot;0;0] + Rot_b_2*[0;theta_dot;0] + Rot_b_2*Rot_2_1*[0;0;psi_dot];

% p = T_inv_calc(1,:);
% q = T_inv_calc(2,:);
% r = T_inv_calc(3,:);
% [c1,t1] = coeffs(p,[gamma_dot theta_dot psi_dot]);
% [c2,t2] = coeffs(q,[gamma_dot theta_dot psi_dot]);
% [c3,t3] = coeffs(r,[gamma_dot theta_dot psi_dot]);

eqns = [T_inv_calc(1,:);...
        T_inv_calc(2,:);...
        T_inv_calc(3,:)];
vars = [gamma_dot; theta_dot; psi_dot];

T_inv = equationsToMatrix(eqns,vars);

T = inv(T_inv);
T = simplify(T);


Rot_b_G1 = rotate_Z_so3(alpha1);            % In accordance with 56
Rot_G1_G2 = rotate_Y_so3(alpha2);          % In accordance with 56
Rot_G2_p = rotate_X_so3(alpha3);          % In accordance with 56

Rot_G1_B = transpose(rotate_Z_so3(psi));            % In accordance with 56
Rot_G2_G1 = transpose(rotate_Y_so3(theta));          % In accordance with 56
Rot_p_G2 = transpose(rotate_X_so3(gamma));          % In accordance with 56

Rot_b_p = Rot_b_G1*Rot_G1_G2*Rot_G2_p      % In accordance with 56




