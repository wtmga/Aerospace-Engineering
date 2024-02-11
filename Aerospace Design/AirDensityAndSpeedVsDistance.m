MTOW = 93500 %maximum takeoff mass of the aircraft in kilograms
MZFW = 73800 %maximum zero fuel mass of the aircraft in kilograms
R = 6100 %distance flown by the aircraft in kilometers
p1 = 0.4138 %air density at 10,000 meters in kilograms per meter cubed
CDo = 0.0424 %zero lift drag coefficient
K = 0.1267 %constant
g = 9.81 %acceleration due to gravity in meters per second squared
S = 122.6 %wing surface area in meters squared
 
m = linspace(MTOW,MZFW) %changing value of mass starting from maximum takeoff mass and ending with maximum zero fuel mass of the aircraft
distance = linspace(0,R) %distance traveled starting from zero to the range
CLMD = sqrt(CDo./K) %minimum drag coefficient of lift
 
figure(1) %generates plot on separate window
V1 = sqrt((2.*MTOW.*g)./(p1.*S.*CLMD)) %true air speed equation
p2 = (2.*m.*g)./(V1.^2.*S.*CLMD) %density equation
plot(distance,p2) %plots air density against distance traveled
 
grid on %displays grid on graph
title('Air Density vs Distance Traveled for Airbus A321') %title of graph
xlabel('Distance Traveled/km') %name of independent variable on graph
ylabel('Air Density/kgm^-^3') %name of dependent variable on graph


figure(2) %generates plot on separate window
V2 = sqrt((2.*m.*g)./(p1.*S.*CLMD)) %true air speed equation
plot(distance,V2) %plots true air speed against distance traveled
 
grid on %displays grid on graph
title('True Air Speed vs Distance Traveled for Airbus A321') %title of graph
xlabel('Distance Traveled/km') %name of independent variable on graph
ylabel('True Air Speed (TAS)/ms^-^1') %name of dependent variable on graph