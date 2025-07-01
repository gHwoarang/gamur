
% Lecture:  Introduction
clear all; clc; close all;

%%  2nd order systems transient response Example 1

num = [0 2 25];
den = [1 4 25];

sys = tf(num,den)

figure
step(sys)
grid on;
set(findall(gcf,'type','line'),'linewidth',2);
set(findall(gca,'type','axes'),'FontSize',12, 'FontWeight', 'bold');


figure
impulse(sys)
grid on;


t = 0:0.1:10;  
r_t = t;
figure
lsim(sys,r_t,t)
grid on;


%% Ex 1 alternative representation

s = tf('s');
sys = (2*s+25)/(s^2+4*s+25);

figure;
step(sys, 'b-')
set(findall(gcf,'type','line'),'linewidth',2);
set(findall(gca,'type','axes'),'FontSize',12, 'FontWeight', 'bold'); 

figure
pzmap(sys)
grid on;

[z,p,k] = zpkdata(sys, 'V')
[wn,zeta,p] = damp(sys) 
 
 
%% Ex 2

num = [0.1 0.35];
den = [1 3 2];
 
impulse(num,den)
 
grid
title('Response of Spring-Mass-Damper System to Initial Condition')

%% Example dominant poles

s = tf('s');
 
TF1 = 24.542/((s^2+4*s+24.542))   
[z,p,k] = zpkdata(TF1, 'V')

TF2 = 245.42/((s+10)*(s^2+4*s+24.542))
[z,p,k] = zpkdata(TF2, 'V')

TF3 = 73.626/((s+3)*(s^2+4*s+24.542))
[z,p,k] = zpkdata(TF3, 'V')

step(TF1, TF2, TF3)
legend('TF1','TF2','TF3')
grid on;
set(findall(gcf,'type','line'),'linewidth',2);
set(findall(gca,'type','axes'),'FontSize',12, 'FontWeight', 'bold'); 

figure
pzmap(TF1,'b', TF2,'g', TF3,'r')
sgrid
legend('TF1','TF2','TF3')
set(findall(gcf,'type','line'),'linewidth',2);
set(findall(gca,'type','axes'),'FontSize',12, 'FontWeight', 'bold'); 

%% Example - pole-zero cancellation
% C1 ----------------------------
b = [1 4];
a= conv ([1 5], [1 6])
a= conv([1 3.5], a)
[r, p, k] = residue(b,a)

s = tf('s');
C = r(1)/(s-p(1)) + r(2)/(s-p(2)) + r(3)/(s-p(3)) 

figure
stepplot(26.5*C, 3);
hold on;
grid on;

b = [1];
a= conv ([1 5], [1 6])
[r, p, k] = residue(b,a)
Crm = r(1)/(s-p(1)) + r(2)/(s-p(2)) 

stepplot(26.5*Crm, 3);

% C2 -----------------------------------
b = [1 4];
a= conv ([1 5], [1 6])
a= conv([1 4.01], a)
[r, p, k] = residue(b,a)

s = tf('s');
C = r(1)/(s-p(1)) + r(2)/(s-p(2)) + r(3)/(s-p(3)) 

figure
stepplot(26.5*C, 3);
hold on;
grid on;

b = [1];
a= conv ([1 5], [1 6])
[r, p, k] = residue(b,a)
Crm = r(1)/(s-p(1)) + r(2)/(s-p(2)) 

stepplot(26.5*Crm, 3);



%% Example - SS-error 1

s = tf('s');
K = 672;
G = (s+5)/(s*(s+6)*(s+7)*(s+8));

CLTF= feedback(K*G,1);
figure;
step(CLTF)
set(findall(gcf,'type','line'),'linewidth',2);
grid on; 

figure
pzmap(CLTF)
grid on;


[z,p,k] = zpkdata(CLTF, 'V')
[wn,zeta,p] = damp(CLTF) 

%ramp input
t = 0:0.1:10;  
r_t = t;
figure
lsim(CLTF,r_t,t)
grid on;

figure
rlocus(G); %check stability
set(findall(gcf,'type','line'),'linewidth',2);
set(findall(gca,'type','axes'),'FontSize',12, 'FontWeight', 'bold');
grid on;
% ax = gca;
% ax.XAxis.FontWeight='bold';
% ax.YAxis.FontWeight='bold';
% ax.XAxis.FontSize = 12;
% ax.YAxis.FontSize = 12;

%% Example - SS-error 2


s = tf('s');
sys = (10*s+4)/(s^2+4*s+4);

figure;
step(sys, 'b-')
set(findall(gcf,'type','line'),'linewidth',2);
set(findall(gca,'type','axes'),'FontSize',12, 'FontWeight', 'bold');
grid on; 

figure
pzmap(sys)
grid on;

[z,p,k] = zpkdata(sys, 'V')
[wn,zeta,p] = damp(sys) 

%ramp input
t = 0:0.1:10;  
r_t = (t);
figure
lsim(sys,r_t,t)
set(findall(gcf,'type','line'),'linewidth',2);
set(findall(gca,'type','axes'),'FontSize',12, 'FontWeight', 'bold');
grid on;

%% Example - Root Locus

s = tf('s');
 
    
Gp = (s+3)/(s*(s+1)*(s^2 + 4*s + 16));

rlocus(Gp);
v = [-6 6 -6 6];
axis(v);
grid on;
title ('Root-Locus Plot of G(s) = K(s + 3)/[s(s + 1)(s^2 + 4s + 16)]');

Gp =  10*Gp;
CLTF= feedback(Gp,1);
figure
step(CLTF, 'r-o'); %% when K = 1







