clear
clc

%INPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = [-0.5,0;1,0]; %comma separates values on the same row, semicolon separates rows
B = [2;0];
g = [1]; %if single input system --> set g as 1, if multiple inputs, then values are given
uPilot = 0; %pilot input

%if desired eigenvalues given, ENTER VALUES IF GIVEN AND SET DAMPING RATIO AND NATURAL FREQUENCY BELOW TO 0
lam1 = 0; %desired eigenvalues, e.g. -10 + 17.3*1i
lam2 = 0;

%if desired damping ratio and natural frequency given, ENTER VALUES IF GIVEN AND SET EIGENVALUES ABOVE TO 0
zeta = 0.707; %damping ratio
omega = 10; %natural frequency in rad/s

%INPUTS END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


sympref('FloatingPointOutput',true); %set number output format
 
syms lam k1 k2 x1 x2

k = [k1,k2];
K = g*k;
BK = B*K;
Astar = A - BK;

disp('Augmented state feedback controller:')
disp('A* = A - BK = A - Bgk')
disp(' ')
disp('K = gk =')
disp(K)
disp('BK =')
disp(BK)
disp('A* = A - BK =')
disp(Astar)


%create state feedback characteristic equation with unknown controller K

insideDetControl = eye(size(Astar))*lam - Astar;
mainDet = collect(det(insideDetControl)); %determinant (equate to 0 to get characteristic equation)
mainExtract = fliplr(coeffs(mainDet, lam)); %extract coefficients wrt lambda
mainLamCoeff = mainExtract(2); %extract coefficients of lambda
mainConst = mainExtract(3); %extract constants

disp('Closed loop characteristic equation:')
disp('eig(A*) = |lambda * I - A*| = 0')
disp(' ')
disp('lambda * I - A* =')
disp(insideDetControl)
disp('|lambda * I - A*| = 0 =')
disp(mainDet)


% create characteristic equation using desired eigenvalues

if zeta == 0 && omega == 0
    desEq = collect((lam - lam1)*(lam - lam2)); %desired eigenvalues in the form of a characteristic equation without = 0)
    desExtract = fliplr(coeffs(desEq, lam)); %extract coefficients wrt lambda
    desLamCoeff = desExtract(2); %extract coefficients of lambda
    desConst = desExtract(3); %extract constants
     
    disp('----------------------------------')
    disp('Desired characteristic equation using desired eigenvalues:')
    disp('(lambda - lambda_1)(lambda - lambda_2) = 0 =')
    disp(desEq)
end


% create characteristic equation using desired damping ratio and natural frequency

if lam1 == 0 && lam2 == 0
    desEq = collect(lam^2 + 2*zeta*omega*lam + omega^2);
    desExtract = fliplr(coeffs(desEq, lam)); %extract coefficients wrt lambda
    desLamCoeff = desExtract(2); %extract coefficients of lambda
    desConst = desExtract(3); %extract constants
    
    disp('----------------------------------')
    disp('Desired characteristic equation using desired damping ratio and natural frequency:')
    disp('lambda^2 + (2*zeta*w_n)lambda + w_n^2 = 0 =')
    disp(desEq)
end


%solve for K

syms k1 k2
 
eqn1 = mainLamCoeff == desLamCoeff; %in the form of lambda coefficient == desired lamba coefficient
eqn2 = mainConst == desConst; %in the form of constant == desired constant
 
%solve system of equations
sol = solve([eqn1, eqn2], [k1, k2]);
k1 = sol.k1;
k2 = sol.k2;
 
K = g*[k1,k2]; %redefine K
uControl = -K*[x1;x2] + uPilot; %controller

disp('----------------------------------')
disp('Compare the constants of the system of 2 equations, unknown constant = desired constant:')
disp(mainConst)
disp('=')
disp(desConst)
disp(' ')
disp('Compare the lambda coefficients of the system of 2 equations, unknown coefficients = desired coefficients:')
disp(mainLamCoeff)
disp('=')
disp(desLamCoeff)
disp(' ')
disp('To get k values:')
disp('k1 =')
disp(k1)
disp('k2 =')
disp(k2)
disp('Which gives controller K = g[k1 k2] =')
disp(K)
disp('And finally control law u = -Kx + u_p = -gkx + u_p =')
disp(uControl)