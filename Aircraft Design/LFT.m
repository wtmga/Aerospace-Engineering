clear all
clc
S=25; %[m2]
N=30; AR=4.667; lambda=0.8; twist=-1; iw=3; alpha_0=0; a_2d=0.5/deg2rad(5);
b=sqrt(S*AR); MAC=S/b; Croot=1.5*MAC*(1+lambda)/(1+lambda+lambda^2);

rho= 0.3639; % [kg/m3]
V=274.4; % [m/s]

% angles (from tip to the root) [rad]
theta=pi/(2*N):pi/(2*N):pi/2

% Segment angle of attack [deg]
alpha=iw+twist:-twist/(N-1):iw;

% Segment location
z=(b/2)*cos(theta)

% Mean chord at every segment
c=Croot*(1-(1-lambda)*cos(theta))

% LHS of the monoplane equation (vector: p)
mu=c*a_2d/(4*b);
p=mu.*(alpha-alpha_0)/57.3;  % divided by 57.3 topass from [deg] to [rad]

% Solve N equations
for i=1:N
    for j=1:N
        K(i,j)=sin((2*j-1)*theta(i))*(1+mu(i)*(2*j-1))/sin(theta(i))
    end
end

A=K\p'

% Calculate lift coefficients
for i=1:N
    sum1(i)=0;
    sum2(i)=0;
    for j=1:N
        sum1(i)=sum1(i)+(2*j-1)*A(j)*sin((2*j-1)*theta(i));
        sum2(i)=sum2(i)+A(j)*sin((2*j-1)*theta(i));
    end
end

CL=4*b*sum2./c;

% Lift coeff of every segment
CL1=[0 CL]

% Locations (tip to root)
y_s=[b/2 z]

% Plot lift distribution
plot(y_s,CL1,'-o')
grid
title('Lift distribution')
xlabel('Loaction in semispan [m]')
ylabel('Lift coefficient')
CL_wing=pi*AR*A(1)

% Lift
L=(1/2)*rho*V^2*S*CL_wing % [Newtons]


