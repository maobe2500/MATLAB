

%% Finding converging roots by graphing

x = linspace(-20, 20, 200);
f = x.^2 - 9.*x - 12*sin(3.*x + 1) + 20;
f0 = x.*0;

plot(x, f)
hold on
plot(x, f0, 'r')

% function has 6 zeros at x= : 1,9 ; 2,7 ; 3,9 ; 4,9 ; 6,0 ; 6,8

% Guesses found in graph of f
x_guess = [1.9 2.7 3.9 4.9 6.0 6.8];


g = @(x) 1/20.*x.^2 + 11/20.*x - 3/5*sin(3.*x+1) + 1;
dg = @(x) 1/10.*x + 11/20 - 9/5*cos(3.*x+1);

% Checking if |dg(x)| < 1 is true at each guess 
for i = 1 : length(x_guess)
    is_lt_1 = abs(dg(x_guess(i)))< 1;
    display(x_guess(i) + " : |dg(x)| < 1 is " + is_lt_1)
end

%{ 
    for x values 1.9, 3.9 and 6
    which means we can find 3 roots of g(x) with fixed point iteration
%}


% ##########################################################################


%% Part C: Fixpunkt.m


% ##########################################################################


%% Part E

%Guesses
x_guess = [1.9 2.7 3.9 4.9 6.0 6.8];
roots = [1 1 1 1 1 1];

%Function
f = @(x) x.^2 - 9.*x - 12*sin(3.*x + 1) + 20;
df = @(x) 2.*x - 9 - 36*cos(3.*x + 1);

% Calculate the root for each of the guesses
for i = 1 : length(x_guess)
    
    x_n = x_guess(i);
    TOL = 10e-10;
    diff = 5;

    while diff > TOL
        
        x_n_plus_1 = x_n - f(x_n)/df(x_n);
        olddiff = diff;
        diff = abs(x_n_plus_1 - x_n);
        
        
        x_n = x_n_plus_1;

        display("x_n: " + x_n + ", diff: " + diff + ", Convergence order: " + log10(diff)/log10(olddiff))

    end

    roots(i) = x_n_plus_1;

end

display(roots)

p = lg(En+1/En)/lg(En/En-1)
p = (lg(En+1)-lg(En))/(lg(En)-lg(En-1))

%%
% Part F

%{
    Stämmer tumregeln för Newtons metod att antalet korrekta siffror dubblas i varje ite-
    ration?

    ####################################

    Svar: Ja, se utskrifter
%}



%%
% Part G

%{
    Jämför konvergensen mellan fixpunktsmetoden och Newtons metod. Vilken metod konvergerar snabbast?
    Hur hänger konvergensen ihop med metodnes konvergensordning? 

    Svar: Newtons metod konvergerar betydligt snabbare än fixpunktmetoden. 
%}