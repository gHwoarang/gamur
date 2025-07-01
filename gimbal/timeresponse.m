%%function e^t

t=-1:0.1:5;

plot(t, exp(-t)); grid on;
hold on;
t=-5:0.1:1;
plot(t, exp(t)); grid on;
legend('e^-t','e^t')

%% sample 1st order
clear;

s = tf('s');

%Gs = (s+2)/((s+5));
Gs = 100/(s+100);
step(Gs);
grid on;

%figure;
%impulse(Gs);


% t = 0:0.1:2;
% u = t;
% u(:) = 1;  %step input
% figure;
% lsim(Gs,u,t);


%%  sample 2nd order
    clear all; clc;

    s = tf('s');
    
    Gs = 0.8*25/(s^2 + s + 25)
    
    step(Gs);
    hold on   
    %figure;
    %pzmap(Gs)
    
 
    [wn,zeta,p] = damp(Gs)  %access to wn, zeta, gain data   

%%  percentovershoot

    OS = 100*exp(-(zeta(1)*pi/sqrt(1-zeta(1)^2)))

%% settling time
    
    Ts = 4/(zeta(1)*wn(1))

%% peak time

    Tp = pi/(wn(1)*sqrt(1-zeta(1)^2))

%% Rise time

    Tr = 1.8/wn(1)

%% poles zeros, gain

    [z,p,k] = zpkdata(Gs, 'V')  %access to poles, zero, gain data

%% faster system //   poles to left
    
    wd = wn(1)*sqrt(1-zeta(1)^2)
    Gsfast = zpk([], [-2.5+j*wd, -2.5-j*wd], 25)


    step(Gsfast, 'b-o')

    [wn,zeta,p] = damp(Gsfast) 

%% higher order system ----------------------------------------------------------------
clear all; clc;

    s = tf('s');
    
    Gs = 1000/((s+5)*(s^2 + 20*s + 400)) %real pole  dominant
    
    [z,p,k] = zpkdata(Gs, 'V')
    
    step(Gs, 'g-o')
    hold on
    
    Gs2 = 1000/((s+5)*(s^2 + 2*s + 400)) %complex poles dominant
    
    [z,p,k] = zpkdata(Gs2, 'V')
    
    step(Gs2,  'b-o')

    % figure;
    % pzmap(Gs)
    % hold on
    % pzmap(Gs2)

%% effect of zeros

    s = tf('s');
    
    Gs = 25/(s^2 + 10*s + 25)
    
    step(Gs, 'r-o')
    
    hold on
    
    Gst = 25*(s+1)/(s^2 + 10*s + 25)
    
    step(Gst, 'y-*')
    
    step (Gs+Gsd, 'g-diamond') 
    
    legend('original poles', 'derivative', 'total')


%----- smaller zero
    % Gs = 25/(s^2 + 10*s + 25);
    % Gs2 = 25*(s+3)/(s^2 + 10*s + 25);
    % 
    % step(Gs, 'r-o')
    % hold on 
    % step(Gs2, 'g-diamond')
    % legend('no-zero', 'w/ zero' )



%% pole zero cancellation

    s = tf('s');
    
    Gs = 400*(s+4.99)/((s+5)*(s^2 + 20*s + 400))
    
    step(Gs, 'b-*')
    
    hold on
    
    Gs2nd = 400 /( (s^2 + 20*s + 400))
    
    step(Gs2nd, 'r-o')
    
    legend('original poles', '2nd order approximate' )
    
    
 %% non-minimum phase systems
 
    s = tf('s');
    
    Gs = -(s-5)/(s^2 + 2*s + 5)
    
    step(Gs, 'b-*')
 