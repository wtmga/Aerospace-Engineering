s=tf('s')

G = ()/()
K = (1)/(1)
H = (1)/(1)
F = (1)/(1)

L = G*K*H*F

[P,Z] = pzmap(L);
RHP_P = sum(P(:) > 0)

nyquist(L)

N = 'How many (clockwise +ve) encirclements of -1 are there? ';
if input(N) + RHP_P == 0
    disp('Stable')
else
    disp('Unstable')
end