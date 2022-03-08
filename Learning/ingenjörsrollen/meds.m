
%% Uppgift 2

t = 0:10;
y0 = @(t) 640.*0.8.^t;
y_effective = 100;

plot(t, y0(t));
hold on
yline(y_effective);
hold on
scatter(8.3188511585, y0(8.3188511585), 'c', 'LineWidth', 2)
title('y = 0,8^t * 640')
ylabel('mg / liter')
xlabel('Timmar')
hold off



%% Uppgift 3

wing_length = [0.5, 1.5, 2, 2.5, 3];
weight = [0.77, 1.1, 1.22, 1.33, 1.4];

xfit = linspace(min(weight), max(weight), length(weight));

b1 = polyfit(weight, wing_length, 1);
yfit2 = polyval(b1, xfit);

log_wing = log(wing_length)
root_wing = wing_length.^1/2

x = weight';
y = root_wing';
N = length(x);

X = [ones(N,1), x];
Y = y;
b = X\Y
y1 = @(x) b(2)*x + b(1); 

realy = @(x) 

%{
b2 = polyfit(weight, wing_length, 2);
yfit1 = polyval(b2, xfit);
%}


display(b1)
display(b2)

plot(weight, wing_length, 'o-', 'LineWidth', 2);
hold on
%plot(weight, root_wing)
%hold on
plot(weight, log_wing, 'LineWidth', 1)
hold on 
plot(weight, y1(weight), 'r', 'LineWidth', 2)
hold on 
plot(weight, realy(weight),'g', 'LineWidth', 2)
%plot(xfit, yfit2, '-', 'LineWidth', 2)
%plot(xfit, yfit1, 'r-', 'LineWidth', 2)

legend({'Linje genom data', 'y=>log(y)', 'y=2.8380x-2.8193', 'y=0.0596*17.0816^x'},'Location','southeast');
title('Given data med vingstorlek och vikt')
title('Vingstorlek som funktion av vikt')
ylabel('Vingstorlek (feet)')
xlabel('Vikt (lb)')
hold off

