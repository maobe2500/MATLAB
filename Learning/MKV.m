%% b) Plot the model and the data.
load('STOCKHOLMARLANDA (1).mat')
% Plot the data
subplot(2,2,1)
x = 1 : length(Tm);
c = linspace(1,10,length(x));
scatter(x, Tm, 1, c, 'filled')
hold on

%Variables
w = (2*pi)/(365*24);

% model and error 
[T, rmse] = least_square(w, Tm);
plot(x, T(x), 'r', 'LineWidth', 2)
title('Hourly temp data and fitted model')





%% c) Caclulate root mean square error

[T, rmse] = least_square(w, Tm);
display(rmse);





%% d) Large scale trend in temperature change 2009-2021, varmest / coldest days of the year? 

format short;
load('STOCKHOLMARLANDA (1).mat')

hour_index = 1;
year_temps = ones(13, 3);
for j = 1 : length(year_temps)
    
    % Adjusts no. days to leap years
    if mod(j, 4) == 0            %leap year every 4th year, as from 2009 and forth (2012, 2016, 2020)
        year_length = 366;
    else
        year_length = 365;
    end
    
    
    year_day_temps = ones(1, year_length);
    year_temp_sum = 0;
    
    for day = 1 : year_length   % loops through days of the year
        day_temp_sum = 0;
        for hour = 1 : 24       % loops through hours of day
            day_temp_sum = day_temp_sum + Tm(hour_index);
            hour_index = hour_index + 1;                        % to access hour temperature in Tm list 
        end
        day_temp_avg = day_temp_sum / 24;
        year_day_temps(day) = day_temp_avg;
        year_temp_sum = year_temp_sum + day_temp_sum;           % sum of all measured temps throughout year
    end
    
    max_temp = max(year_day_temps);
    min_temp = min(year_day_temps);
    day_number_max = find(year_day_temps==max_temp);
    day_number_min = find(year_day_temps==min_temp);
    %display(day_number_max)
    %display(day_number_min)
    year_temp_avg = year_temp_sum/(24*year_length);         % calcs avg hourly temp of year
    year_temps(j, 1) = year_temp_avg;                             % compiles average temp of years 2009-2021
    year_temps(j, 2) = day_number_max;      
    year_temps(j, 3) = max_temp;
    year_temps(j, 4) = day_number_min;
    year_temps(j, 5) = min_temp;
end

avg_temps = year_temps(:,1);
max_days = year_temps(:,2);
max_temps = year_temps(:,3);
min_days = year_temps(:,4);
min_temps = year_temps(:,5);

% Display table in command window
Table = table(avg_temps, max_days, max_temps, min_days, min_temps);
display(Table)

% Fitted line showing slight increase in year_temp
subplot(2,2,2)
x = 2009 : 2008 + length(year_temps);           % 13 years
plot(x, avg_temps)
hold on
k = x'\avg_temps;
y = k*x;
plot(x, y)
title('Average year temp')





%% e) Medeltemp per dag
clear
load('STOCKHOLMARLANDA (1).mat')

n = 1;
day_avg_list = ones(length(Tm)/24);


k = 1;
while k <= length(Tm)/24
    day = Tm(n:n+23);
    day_avg = sum(day)/24;
    day_avg_list(k) = day_avg;
    n = n + 24;
    %display(day_avg);

    k = k + 1;
end

subplot(2,2,[3,4])
% New w value
w = (2*pi)/(365);
x = 1 : length(day_avg_list);
plot(x, day_avg_list);
hold on;

[T, rmse] = least_square(w, day_avg_list);
plot(x, T(x), 'r', 'LineWidth', 2);
title('Average day temp')
display(rmse);
















%% FUNCTIONS
function [T, rmse] = least_square(w, temp_list)
    ts = 1; %WHAT IS THIS
    A = ones(length(temp_list), 4);
    b = ones(length(temp_list), 1);

    % Create A and b
    for i = 1 : length(temp_list)
        A(i, 1) = 1;
        A(i, 2) = i;
        A(i, 3) = sin(w.*i);
        A(i, 4) = cos(w.*i);
        b(i) = temp_list(i);
    end
    % Solution
    X = inv(A'*A)*A'*b;
    c1 = X(1);
    c2 = X(2);
    c3 = X(3); % cos(w.*ts)
    c4 = X(4); % -sin(w.*ts) 
    T = @(t) c1 + c2.*t + c3*sin(w.*t) + c4*cos(w.*t);

    % RMSE, roten av summan av felen i kvadrat genom antalet fel (för medelvärde)
    sum = 0;
    for i = 1 : length(temp_list)
        actual = temp_list(i);
        predicted = T(i);
        sqrd_diff = (predicted - actual).^2;
        sum = sum + sqrd_diff;
    end

    rmse = sqrt(sum/length(temp_list));
end