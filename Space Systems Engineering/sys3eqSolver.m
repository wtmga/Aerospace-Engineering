clear
clc
 
syms j1;  %node 1
syms j2;  %node 2
syms t1;  %temp of potential of node 1
 
sig = 5.67*10^(-8);  %constant (sigma)
ep = 0.7;  %emissivity (epsilon)
q = 200;  %external heat added to potential of node 1
 
a1 = 1;  %areas (by node number)
a2 = 1;
 
f12 = 0.2;  %view factors (in form fxy: fraction of radiation that leaves surace x and falls directly onto surface y, y=3 is radiation to space)
f13 = 0.8;
 
f21 = 0.2;
f23 = 0.8;
 
source = q + ((ep*a1)/(1-ep))*(j1-sig*t1^4) == 0;  %enter left and right hand terms of all equations
node1 = ((ep*a1)/(1-ep))*(sig*(t1^4)-j1)+a1*f13*(0-j1)+a1*f12*(j2-j1) == 0;
node2 = a2*f23*(0-j2)+a1*f12*(j1-j2) == 0;
 
sol = solve([source, node1, node2], [j1, j2, t1]);  %solve
node1_j1 = double(sol.j1(1))  %picks first out of four identical solutions
node2_j2 = double(sol.j2(1))
tempOfPotentialOfNode1_t1 = double(sol.t1(real(sol.t1)>0&imag(sol.t1)==0))  %picks positive and real solution