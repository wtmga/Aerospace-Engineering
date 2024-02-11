clc
clear
N = 20; % (number of segments-1)
S = 91.32; % m ˆ 2
AR = 4.6666666667; % Aspect ratio
lambda = 0.42; % Taper ratio
alpha_twist = 0.00000000000000000000000000000000000001; % Twist angle (deg)
a_h = 0.43; % tail angle of attack (deg)
a_2d = 0.5/deg2rad(4.5); % lift curve slope (1/rad)
alpha_0 = 0; % zero-lift angle of attack (deg)

b = sqrt(AR*S); % tail span
MAC = S/b; % Mean Aerodynamic Chord
Croot = (1.5*(1+lambda)*MAC)/(1+lambda+lambda*lambda); % root chord
theta = pi/(2*N):pi/(2*N):pi/2;
alpha=a_h+alpha_twist:-alpha_twist/(N-1):a_h;
% segment’s angle of attack
z = (b/2)*cos(theta);
c = Croot * (1 - (1-lambda)*cos(theta)); % Mean Aerodynamics chord at each segment
mu = c * a_2d / (4 * b);
LHS = mu .* (alpha-alpha_0)/57.3; % Left Hand Side
% Solving N equations to find coefficients A(i):
for i=1:N
    for j=1:N
        B(i,j)=sin((2*j-1) * theta(i)) * (1+(mu(i) *(2*j-1))/sin(theta(i)));
    end
end
A=B\transpose(LHS);
for i = 1:N
    sum1(i) = 0;
    sum2(i) = 0;
    for j = 1 : N
        sum1(i) = sum1(i) + (2*j-1) * A(j)*sin((2*j-1)*theta(i));
        sum2(i) = sum2(i) + A(j)*sin((2*j-1)*theta(i));
    end
end
CL_tail = pi * AR * A(1)
