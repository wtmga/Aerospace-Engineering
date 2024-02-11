p = 0.3650 %air density at cruise level of 11,000 meters in kilograms per meters cubed
V = linspace(50,350) %range of true air speed to be plotted in meters per second
S = 122.6 %wing surface area in meters squared
CDo = 0.0424 %zero lift drag coefficient
K = 0.1267 %constant in drag polar equation
m = 500 %mass of aircraft in kilograms
g = 9.81 %acceleration due to gravity in meters per second squared
 
n_lft_drg = .5.*p.*V.^2.*S.*CDo %no lift drag equation
lft_dpndnt_drg = (K.*(m.*g).^2)./(.5.*p.*V.^2.*S) %lift dependent drag equation
tot_drg = n_lft_drg + lft_dpndnt_drg %total drag which is the sum of the no lift and lift dependent drag equations

figure(1) %generates plot on separate window
plot(V,n_lft_drg,V,lft_dpndnt_drg,V,tot_drg) %plots no lift, lift dependent, and total drag against true air speed
grid on %displays grid on graph
title('Drag vs True Air Speed for Airbus A321') %title of graph
xlabel('True Air Speed (TAS)/ms^-^1') %name of independent variable on graph
ylabel('Drag/N') %name of dependent variable on graph
legend('No lift drag','Lift dependent drag','Total drag') %displays relationship between curve color and equation on graph
 
[min_drg, min_drg_ndx] = min(tot_drg) %obtains minimum value of drag and index of that value from the total drag equation
min_drg_TAS = V(min_drg_ndx) %obtains true air speed value when drag is minimum using its index (of minimum drag)
text(min_drg_TAS,min_drg+10^5,sprintf('Minimum Drag TAS = %f ms^-^1',min_drg_TAS)) %displays the minimum drag TAS above that point


n_lft_pwr = .5.*p.*V.^3.*S.*CDo %no lift power equation
lft_dpndnt_pwr = (K.*(m.*g).^2)./(.5.*p.*V.*S) %lift dependent power equation
tot_pwr = n_lft_pwr + lft_dpndnt_pwr %total power which is the sum of the no lift and lift dependent power equations

figure(2) %generates plot on separate window
plot(V,n_lft_pwr,V,lft_dpndnt_pwr,V,tot_pwr) %plots no lift, lift dependent, and total power against true air speed
grid on %displays grid on graph
title('Power vs True Air Speed for Airbus A321') %title of graph
xlabel('True Air Speed (TAS)/ms^-^1') %name of independent variable on graph
ylabel('Power/W') %name of dependent variable on graph
legend('No lift power','Lift dependent power','Total power') %displays relationship between curve color and equation on graph
 
[min_pwr, min_pwr_ndx] = min(tot_pwr) %obtains minimum value of power and index of that value from the total power equation
min_pwr_TAS = V(min_pwr_ndx) %obtains true air speed value when power is minimum using its index (of minimum power)
text(min_pwr_TAS,min_pwr+10^7,sprintf('Minimum Power TAS = %f ms^-^1',min_pwr_TAS)) %displays the minimum power TAS above that point