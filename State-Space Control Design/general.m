%% STATE SPACE MODELLING
%% equilibrium
syms x(t);
cond = x(0) == 1;   %INPUT
ode = diff(x(t),t) == -x(t) + exp(-t);   %INPUT
pretty(ode)
dsolve(ode,cond)
 
 
 
%% STABILITY
%% eigenvalues
A = [0;0];   %INPUT
eigenvalues = eig(A)
%% state space to transfer
A = [0;0];   %INPUT
B = [0;0];   %INPUT
C = [0;0];   %INPUT
D = [0;0];   %INPUT
iu = 0;   %INPUT
[numOut,denOut] = ss2tf(A,B,C,D,iu)
%% transfer to state space
num = 0;   %INPUT
den = 0;   %INPUT
[AOut,BOut,COut,DOut] = tf2ss(num,den)
 
 
 
%% DYNAMIC BEHAVIOR
%% eigenvector and eigenvalue
A = [0;0];   %INPUT
[VColREigVec,eigDiag] = eig(A)
%% modal canonical
A = [0;0];   %INPUT
B = [0;0];   %INPUT
C = [0;0];   %INPUT
D = [0;0];   %INPUT
T = [0;0];   %INPUT
Tinv = inv(T)
Atild = inv(T)*A*T
Btild = inv(T)*B
Ctild = C*T
Dtild = D
%% discrete state space
F = [0;0];   %INPUT
G = [0;0];   %INPUT
H = [0;0];   %INPUT
J = [0;0];   %INPUT
Ts = 0;   %INPUT
sys_discrete = ss(F,G,H,J,Ts)
%% continuous state space
A = [0;0];   %INPUT
B = [0;0];   %INPUT
C = [0;0];   %INPUT
D = [0;0];   %INPUT
sys_continuous = ss(A,B,C,D)
%% continuous to discrete
A = [0;0];   %INPUT
B = [0;0];   %INPUT
C = [0;0];   %INPUT
D = [0;0];   %INPUT
sys_continuous = ss(A,B,C,D)
Ts = 1;   %INPUT
sys_cont2disc = c2d(sys_continuous,Ts,'zoh') 
%% matrix exponential
A = [0;0];   %INPUT
t = 0;   %INPUT
matExpon = expm(A*t)	
%% discrete responses using continuous sys
A = [0;0];   %INPUT
B = [0;0];   %INPUT
C = [0;0];   %INPUT
D = [0;0];   %INPUT
sys_continuous = ss(A,B,C,D)
tvec = (0:0:0);   %INPUT
uvec = ones(length(tvec),1);   %INPUT
x_zero = 0;   %INPUT
Y = lsim(sys_continuous,uvec,tvec,x_zero,'zoh')
 
 
 
%% REACHABILITY AND OBSERVABILITY
%% reachability
A = [0;0];   %INPUT
B = [0;0];   %INPUT
Wc = ctrb(A,B)
reachRank = rank(ctrb(A,B))	
%% observability
A = [0;0];   %INPUT
C = [0;0];   %INPUT
Wo = obsv(A,C)		
obsRank = rank(obsv(A,C))
 
 
 
%% FULL STATE FEEDBACK CONTROL
%% pole placement
A = [0;0];   %INPUT
B = [0;0];   %INPUT
P = 0;   %INPUT
K = place(A,B,P) 
%% acker pole placement
A = [0;0];   %INPUT
B = [0;0];   %INPUT
P = 0;   %INPUT
K = acker(A,B,P)	
%% lqr
A = [0;0];   %INPUT
B = [0;0];   %INPUT
Qx = 0;   %INPUT
Qu = 0;   %INPUT
[KOut,POut,CLP] = lqr(A,B,Qx,Qu)
 
 
 
%% OBSERVER DESIGN
%% observer state space
F = [0;0];   %INPUT
G = [0;0];   %INPUT
Gw = [0;0];   %INPUT
H = [0;0];   %INPUT
J = [0;0];   %INPUT
Ts = 1;   %INPUT
sys = ss(F,[G Gw],H,J,Ts)
%% minreal
F = [0;0];   %INPUT
G = [0;0];   %INPUT
Gw = [0;0];   %INPUT
H = [0;0];   %INPUT
J = [0;0];   %INPUT
Ts = 1;   %INPUT
sys = ss(F,[G Gw],H,J,Ts)
sys_minreal = minreal(sys)
%% kalman
F = [0;0];   %INPUT
G = [0;0];   %INPUT
Gw = [0;0];   %INPUT
H = [0;0];   %INPUT
J = [0;0];   %INPUT
Ts = 1;   %INPUT
sys = ss(F,[G Gw],H,J,Ts)
Rw = 0;   %INPUT
Rv = 0;   %INPUT
[kest L] = kalman(sys,Rw,Rv)
