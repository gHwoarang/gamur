clc
clear all
close all
%% Frame Initialization at t = 0
frame_e = unitAxis(0, 0, 0);
frame_1 = unitAxis(0, 0, 0);
frame_2 = unitAxis(0, 0, 0);
frame_b = unitAxis(0, 0, 0);
frame_G1 = unitAxis(0, 0, 0);
frame_G2 = unitAxis(0, 0, 0);
frame_p = unitAxis(0, 0, 0);

%% System Configuration at t = 0
x = 0;


y = 0;


z = 0;


psi = 0;


theta = 0;


gamma = 0;


alpha1 = 0;


alpha2 = 0;


alpha3 = 0;


L1 = 2; % distance of camera focal point from IMU sensor
line_camera_0 = [0,  0; 
                  0,  0;
                  0, L1; 
                  1,  1];

Tr_focal = translate(0,0,L1);   

%% Signal length
tmax = 5;               %max time secs
% Fs = 12800;             %sampling frequency
Fs = 128;             %sampling frequency
Ts = 1/Fs;              %sampling period
L_array = Fs*tmax;      %array length
t = (0:L_array-1)*Ts;   %sampling time
[~, t_size] = size(t);

%% IMU Signal Seed
% Translational Signal
u = ones(1,t_size)*2;
v = zeros(1,t_size);
w = zeros(1,t_size);

% Rotational Signal
% p = zeros(1,t_size);
% p = ones(1,t_size);
p = 0.8*sin(t*pi*2);

% q = zeros(1,t_size);
q = 0.8*sin(t*pi*2);

r = ones(1,t_size)*0.8;
% r = 0.8*sin(t*pi*2);

%% Target Coordinates
x_target = 35.0;
y_target = 10.0;
z_target = 11.0;

%%

% Rotation Matrices
Rz_psi_so3 = rotate_Z_so3(psi);
Ry_theta_so3 = rotate_Y_so3(theta);
Rx_gamma_so3 = rotate_X_so3(gamma);

Rz_psi_se3 = rotate_Z_se3(psi);
Ry_theta_se3 = rotate_Y_se3(theta);
Rx_gamma_se3 = rotate_X_se3(gamma);

Rz_alpha1_se3 = rotate_Z_se3(alpha1);
Ry_alpha2_se3 = rotate_Y_se3(alpha2);
Rx_alpha3_se3 = rotate_X_se3(alpha3);

figure('units','normalized','outerposition',[0 0 1 1])
for i = 1:t_size
    % Position Calculation
    R_ptg = Rz_psi_so3*Ry_theta_so3*Rx_gamma_so3;   % Transformation Matrix for position from "base" to "earth"
    position_dot = R_ptg*[u(i);v(i);w(i)];          % Takes reading from IMU Signal seed
    position = Ts*position_dot + [x; y; z];         % Discrete integral (Piecewise rn, trapezoidal integration or Simpson'S Rule may be needed.)

    x = position(1);    %Assigning new coordinates of the base
    y = position(2);
    z = position(3);

    % Euler Angle Calculation
    T = zyx_Euler_Converter(gamma, theta);  % T[psi, theta, gamma]
    Euler_dot = T*[p(i);q(i);r(i)];                  
    Euler_Angles = Ts*Euler_dot + [gamma; theta; psi];  %Discrete Integration
    gamma = Euler_Angles(1);    %Assigning new Euler Angles
    theta = Euler_Angles(2);
    psi = Euler_Angles(3);

    %Reassign
    Rz_psi_so3 = rotate_Z_so3(psi);
    Ry_theta_so3 = rotate_Y_so3(theta);
    Rx_gamma_so3 = rotate_X_so3(gamma);

    Rz_psi_se3 = rotate_Z_se3(psi);
    Ry_theta_se3 = rotate_Y_se3(theta);
    Rx_gamma_se3 = rotate_X_se3(gamma);

    % Camera Focal Point
    Tr = translate(x,y,z);
    camera_instant = Tr*Rz_psi_se3*Ry_theta_se3*Rx_gamma_se3*line_camera_0; % line_camera_0 is defined in "Base" frame
    x_camera = camera_instant(1,2);
    y_camera = camera_instant(2,2);
    z_camera = camera_instant(3,2);
    
    % Desired Camera Orientation
    distance = sqrt((x_target-x_camera)^2+(y_target-y_camera)^2+(z_target-z_camera)^2); 
    X_desired_unit = [x_target-x_camera; y_target-y_camera; z_target-z_camera]/distance;
    X_d1 = [X_desired_unit(1); X_desired_unit(2); 0];
    X_d2 = [0;0;X_desired_unit(3)];
    skewX_d2 = skewSymmetricMatrix(X_d2);
    Y_desired = skewX_d2*X_d1;
    Y_desired_unit = Y_desired/sqrt((Y_desired(1))^2+(Y_desired(2))^2+(Y_desired(3))^2);

    skewX_desired = skewSymmetricMatrix(X_desired_unit);
    Z_desired = skewX_desired*Y_desired;
    Z_desired_unit = Z_desired/sqrt((Z_desired(1))^2+(Z_desired(2))^2+(Z_desired(3))^2);


    R_desired = [X_desired_unit, Y_desired_unit, Z_desired_unit];  % after 6 rotation this should be achieved
    R_desired_b = transpose(Rx_gamma_so3)*transpose(Ry_theta_so3)*transpose(Rz_psi_so3)*R_desired;

%     alpha1 = atan2(R_desired_b(2,1), R_desired_b(1,1));
%     alpha2 = atan2(-R_desired_b(3,1), sqrt(R_desired_b(3,2)^2 + R_desired_b(3,3)^2));
%     alpha3 = atan2(R_desired_b(3,2), R_desired_b(3,3));
    % Dogru ama cos(alpha2) neden?
%     alpha2 = atan2(-R_desired_b(3,1), sqrt(R_desired_b(1,1)^2 + R_desired_b(2,1)^2));
%     alpha1 = atan2(R_desired_b(2,1)/cosd(alpha2), R_desired_b(1,1)/cosd(alpha2));
%     alpha3 = atan2(R_desired_b(3,2)/cosd(alpha2), R_desired_b(3,3)/cosd(alpha2));

    alpha2 = atan2(-R_desired_b(3,1), sqrt(R_desired_b(1,1)^2 + R_desired_b(2,1)^2));
    alpha1 = atan2(R_desired_b(2,1), R_desired_b(1,1));
    alpha3 = atan2(R_desired_b(3,2), R_desired_b(3,3));
    
    % Reassign
    Rz_alpha1_se3 = rotate_Z_se3(alpha1);
    Ry_alpha2_se3 = rotate_Y_se3(alpha2);
    Rx_alpha3_se3 = rotate_X_se3(alpha3);

    LOS_line = [x_camera, x_target; y_camera, y_target; z_camera, z_target];

    clf
    grid on
    hold on
    obj_holder = [];

    obj1 = plot3(x_target, y_target, z_target, "om", 'MarkerSize', 5, 'LineWidth', 3);
    obj_holder = [obj_holder, obj1];

    [obj1, obj2, obj3] = unitAxis_Drawer(frame_e, "k", "k", "k", 1);
    obj_holder = [obj_holder, obj1, obj2, obj3];

    frame_1_ins = Tr*Rz_psi_se3*frame_1;
    [obj1, obj2, obj3] = unitAxis_Drawer(frame_1_ins, "r", "r", "r", 1);
    obj_holder = [obj_holder, obj1, obj2, obj3];

    frame_2_ins = Tr*Rz_psi_se3*Ry_theta_se3*frame_2;
    [obj1, obj2, obj3] = unitAxis_Drawer(frame_2_ins, "g", "g", "g", 1);
    obj_holder = [obj_holder, obj1, obj2, obj3];

    frame_b_ins = Tr*Rz_psi_se3*Ry_theta_se3*Rx_gamma_se3*frame_b;
    [obj1, obj2, obj3] = unitAxis_Drawer(frame_b_ins, "b", "b", "b", 1);
    obj_holder = [obj_holder, obj1, obj2, obj3];

    frame_G1_ins = Tr*Rz_psi_se3*Ry_theta_se3*Rx_gamma_se3*Tr_focal*Rz_alpha1_se3*frame_G1;
    [obj1, obj2, obj3] = unitAxis_Drawer(frame_G1_ins, "r", "r", "r", 1);
    obj_holder = [obj_holder, obj1, obj2, obj3];

    frame_G2_ins = Tr*Rz_psi_se3*Ry_theta_se3*Rx_gamma_se3*Tr_focal*Rz_alpha1_se3*Ry_alpha2_se3*frame_G2;
    [obj1, obj2, obj3] = unitAxis_Drawer(frame_G2_ins, "g", "g", "g", 1);
    obj_holder = [obj_holder, obj1, obj2, obj3];

    frame_p_ins = Tr*Rz_psi_se3*Ry_theta_se3*Rx_gamma_se3*Tr_focal*Rz_alpha1_se3*Ry_alpha2_se3*Rx_alpha3_se3*frame_p;
    [obj1, obj2, obj3] = unitAxis_Drawer(frame_p_ins, "b", "b", "b", 2);
    obj_holder = [obj_holder, obj1, obj2, obj3];
    
    
    plot3(LOS_line(1,:), LOS_line(2,:), LOS_line(3,:))
%     obj1 = plot3(camera_instant(1,:),camera_instant(2,:),camera_instant(3,:),"k-o");
%     obj_holder = [obj_holder, obj1];

    hold off
    axis equal

    xlim([-15, 40])
    ylim([-15, 15])
    zlim([-1, 15])
    view(-45,20)
%     view(0,0)

%     view_camera = [x_camera-X_desired(1,1)*5, y_camera-X_desired(2,1)*5, z_camera-X_desired(3,1)*5];
%     campos([view_camera(1), view_camera(2), view_camera(3)])
%     camtarget([x_target,y_target,z_target])
    pause(0.01)
end



% view(45,20)
