clear
clc

CMaf = -0.04;
ARWing = 7;
BigLambdawing = deg2rad(25);
Twist = -1;
nh = 0.9;
h_h0 = 0.15;
CL = 0.45;
Vh = 1.1;
Df = 3.9;
Cwing = 7.071;
Swing = 350;
Lambdah = 0.42;
Vv = 0.09;
bwing = 49.5;
ARv = 1.64;
Lambdav = 0.365;


CMwf = CMaf * ((ARWing*cos(BigLambdawing)^2)/(ARWing + 2*cos(BigLambdawing)))+ 0.01*Twist

CLh = (CMwf+CL*h_h0)/(nh*Vh)

lopt = sqrt((4*Cwing*Swing*Vh)/(pi*Df))

Sh = (Vh*Cwing*Swing)/lopt

ARh = (2/3) * ARWing

bh = sqrt(ARh*Sh)

Ch = Sh/bh

Chroot = (3/2)*Ch*((1+Lambdah)/(1+Lambdah+Lambdah^2))

Chtip = Lambdah*Chroot

Sv = (Vv*bwing*Swing)/lopt

bv = sqrt(ARv*Sv)

Cv = Sv/bv

Cvroot = (3/2)*Cv*((1+Lambdav)/(1+Lambdav+Lambdav^2))

Cvtip = Lambdav*Cvroot