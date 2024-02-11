clear
clc

%INPUTS

rFinal = (42241+250)*10^3;  %(m) final (circular) orbit
rInitial = (42241)*10^3;  %(m) initial (circular) orbit
inclination = 0;  %(degrees) inclination
mu = 3.986004418*10^14;  %(m^3/s^2) gravitational parameter

%END OF INPUTS

d = rFinal/rInitial;  %(rFinal/rInitial) radii ratio

if d < 11.94  %test efficiency of Hohmann
    fprintf('d = rFinal/rInitial\n= %d/%d\n= %f < 11.94 --> Hohmann transfer more efficient than bielliptic\n\n', rFinal, rInitial, d)
else
    fprintf('d = rFinal/rInitial\n= %d/%d\n= %f > 11.94 --> Bielliptic transfer more efficient than Hohmann dis script aint gon work\n\n', rFinal, rInitial, d)
end

vInitial = sqrt(mu/rInitial);  %initial velocity
fprintf('vInitial = sqrt(mu/rInitial)\n= sqrt(%d/%d)\n= %f m/s\n\n', mu, rInitial, vInitial)

vFinal = sqrt(mu/rFinal);  %final velocity
fprintf('vFinal = sqrt(mu/rFinal)\n= sqrt(%d/%d)\n= %f m/s\n\n', mu, rFinal, vFinal)

a = (rInitial + rFinal)/2;  %semimajor axis
fprintf('a = (rInitial + rFinal)/2\n= (%d + %d)/2\n= %f m\n\n', rInitial, rFinal, a)

vPerigee = sqrt(((2*mu)/rInitial)-(mu/a));  %perigee velocity
fprintf('vPerigee = sqrt(((2*mu)/rInitial) - (mu/a))\n= sqrt(((2*%d)/%d) - (%d/%d))\n= %f m/s\n\n', mu, rInitial, mu, a, vPerigee)

vApogee = sqrt(((2*mu)/rFinal)-(mu/a));  %apogee velocity
fprintf('vApogee = sqrt(((2*mu)/rFinal) - (mu/a))\n= sqrt(((2*%d)/%d) - (%d/%d))\n= %f m/s\n\n', mu, rFinal, mu, a, vApogee)

deltaVfirstPulse = vPerigee - vInitial;  %change in velocity required for first pulse
fprintf('deltaVfirstPulse = vPerigee - vInitial\n= %f - %f\n= %f m/s\n\n', vPerigee, vInitial, deltaVfirstPulse)

deltaVsecondPulse = sqrt(vApogee^2+vFinal^2-2*vApogee*vFinal*cosd(inclination));  %change in velocity required for second pulse
fprintf('deltaVsecondPulse = sqrt(vApogee^2 + vFinal^2 - 2*vApogee*vFinal*cos(inclination))\n= sqrt(%f^2 + %f^2 - 2*%f*%f*cos(%f))\n= %f m/s\n\n', vApogee, vFinal, vApogee, vFinal, inclination, deltaVsecondPulse)

sumDeltaV = deltaVfirstPulse + deltaVsecondPulse;
fprintf('sumDeltaV = deltaVfirstPulse + deltaVsecondPulse\n= %f + %f\n= %f m/s\n', deltaVfirstPulse, deltaVsecondPulse, sumDeltaV)