clear all
close all
clc
cgf

% define the system matrices
A = [0, 0, 0;
     0, 0, 0;
     0, 0, 0];

B = [1, 0, 0;
     0, 1, 0;
     0, 0, 1];

C = [1, 0, 0;
     0, 1, 0;
     0, 0, 1];

D = [0, 0, 0;
     0, 0, 0;
     0, 0, 0];

%% Open Loop
% open loop poles
polesOpenLoop = eig(A);

% define the state-space mode
systemOpenLoop = ss(A,B,C,D);

% check the step response in order to check the steady-state error
% step(systemOpenLoop)

%% Pole-Placement Only
p = [2; 3; 4];
K = place(A,B,p);

A_p = A-B*K;

placedPoles = eig(A_p);

systemCloseLoop = ss(A_p,B,C,D);
step(systemCloseLoop)

t = 0:0.01:5;
y = step(A_p,B,C,D,[1;1;1],t);


% AA = [0 1 0;0 0 1;-160 -56 -14];
% BB = [0;0;160];
% CC = [1 0 0];
% DD = [0];
% % ***** Enter step command and plot command *****
% t = 0:0.01:5;
% y = step(AA,BB,CC,DD,1,t);
% plot(t,y)
% grid
% title('Unit-Step Response')
% xlabel('t Sec')
% ylabel('Output y')
