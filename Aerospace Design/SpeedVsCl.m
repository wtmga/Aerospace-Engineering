alt = ["Sea level","5,000 m","10,000 m"] %array containing different altitudes for which the true air speed will be calculated
p = [1.2256 0.7368 0.4138] %array containing corresponding air densities in kilograms per meters cubed
CL = linspace(.6,1.4) %range of CL for which true air speed will be calculated
 
hold on %allows multiple curves on same graph
grid on %displays grid on graph
title('True Air Speed vs Coefficient of Lift for Airbus A321') %title of graph
xlabel('Coefficient of Lift (CL)') %name of independent variable on graph
ylabel('True Air Speed (TAS)/ms^-^1') %name of dependent variable on graph
legend %displays relationship between curve color and altitude on graph
 
for n = 1:3 %loop that plots true air speed against coefficient of lift for different air densities, n is position in array
    plot(CL,TAS(85000,9.81,p(n),122.6,CL),"DisplayName",alt(n)) %plots true air speed against coefficient of lift using TAS function and displays name of curve in stated order from altitude array
end %ends loop