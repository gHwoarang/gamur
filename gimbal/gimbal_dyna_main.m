clear all
close all
clc

% Steady State Error
A = [0, 0, 0;
     0, 0, 0;
     0, 0, 0];

B = [1, 0, 0;
     0, 1, 0;
     0, 0, 1];

p = [-1; -1.2; -1.3];

K = place(A,B,p);

tspan = 0:.001:30;

desired_angle = [2;3;4];

y0 = [0;0;0];
[t,y] = ode45(@(t,y)gimbal_dynamic(y, (desired_angle-K*y)), tspan, y0)