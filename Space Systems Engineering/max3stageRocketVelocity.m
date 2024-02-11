clear
clc

%INPUTS:

mDry1 = 38450;  %kg dry mass (first stage)
mProp1 = 334560;  %kg propellant mass (first stage)
%enter one, leave other as 0:
vEff1 = 4400;  %m/s effective velocity (first stage)  
specImp1 = 0;  %s specific impulse (first stage)
 
mDry2 = 4260;  %kg
mProp2 = 38110;  %kg
%enter one, leave other as 0:
vEff2 = 0;  %m/s
specImp2 = 317;  %s

mDry3 = 1720;  %kg
mProp3 = 12110;  %kg
%enter one, leave other as 0:
vEff3 = 4050;  %m/s
specImp3 = 0;  %s

mPay = 530;  %kg payload mass

g = 9.81;  %m/s^2 gravitational acceleration

%END OF INPUTS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%stage 1 mass and max velocity
m1 = mPay + mDry1 + mProp1 + mDry2 + mProp2 + mDry3 + mProp3;
fprintf('m1 = mPay + mDry1 + mProp1 + mDry2 + mProp2 + mDry3 + mProp3\n= %d + %d + %d + %d + %d + %d + %d\n= %f kg\n\n', mPay, mDry1, mProp1, mDry2, mProp2, mDry3, mProp3, m1)

if vEff1 == 0 && specImp1 > 0
    vMax1 = g*specImp1 * log(m1/(m1-mProp1));
    fprintf('vMax1 = g*specImp1 * ln(m1/(m1-mProp1))\n= %d*%d * ln(%d/(%d-%d))\n= %f m/s\n\n\n', g, specImp1, m1, m1, mProp1, vMax1)
elseif specImp1 == 0 && vEff1 > 0
    vMax1 = vEff1 * log(m1/(m1-mProp1));
     fprintf('vMax1 = vEff1 * ln(m1/(m1-mProp1))\n= %d * ln(%d/(%d-%d))\n= %f m/s\n\n\n', vEff1, m1, m1, mProp1, vMax1)
end
    
%stage 2 mass and max velocity
m2 = m1 - (mDry1 + mProp1);
fprintf('m2 = m1 - (mDry1 + mProp1)\n= %d - (%d + %d)\n= %f kg\n\n', m1, mDry1, mProp1, m2)

if vEff2 == 0 && specImp2 > 0
    vMax2 = g*specImp2 * log(m2/(m2-mProp2)) + vMax1;
    fprintf('vMax2 = g*specImp2 * ln(m2/(m2-mProp2)) + vMax1\n= %d*%d * ln(%d/(%d-%d)) + %f\n= %f m/s\n\n\n', g, specImp2, m2, m2, mProp2, vMax1, vMax2)
elseif specImp2 == 0 && vEff2 > 0
    vMax2 = vEff2 * log(m2/(m2-mProp2)) + vMax1;
    fprintf('vMax2 = vEff2 * ln(m2/(m2-mProp2)) + vMax1\n= %d * ln(%d/(%d-%d)) + %f\n= %f m/s\n\n\n', vEff2, m2, m2, mProp2, vMax1, vMax2)
end

%stage 3 mass and max velocity
m3 = m2 - (mDry2 + mProp2);
fprintf('m3 = m2 - (mDry2 + mProp2)\n= %d - (%d + %d)\n= %f kg\n\n', m2, mDry2, mProp2, m3)

if vEff3 == 0 && specImp3 > 0
    vMax3 = g*specImp3 * log(m3/(m3-mProp3)) + vMax2;
    fprintf('vMax3 = g*specImp3 * ln(m3/(m3-mProp3)) + vMax2\n= %d*%d * ln(%d/(%d-%d)) + %f\n= %f m/s\n', g, specImp3, m3, m3, mProp3, vMax2, vMax3)
elseif specImp3 == 0 && vEff3 > 0
    vMax3 = vEff3 * log(m3/(m3-mProp3)) + vMax2;
    fprintf('vMax3 = vEff3 * ln(m3/(m3-mProp3)) + vMax2\n= %d * ln(%d/(%d-%d)) + %f\n= %f m/s\n', vEff3, m3, m3, mProp3, vMax2, vMax3)
end