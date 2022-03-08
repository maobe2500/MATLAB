
format long

%Guesses
x_guess = [1.9 2.7 3.9 4.9 6.0 6.8];
roots = [1 1 1 1 1 1];

%Function
f = @(x) x.^2 - 9.*x - 12*sin(3.*x + 1) + 20;
df = @(x) 2.*x - 9 - 36*cos(3.*x + 1);

% Calculate the root for each of the guesses
for i = 1 : length(x_guess)
    
    x_old = x_guess(i);
    TOL = 10e-10;
    diff = 1;

    while diff > TOL

        x = x_old - f(x_old)/df(x_old);

        olddiff = diff;
        diff = abs(x_old - x);
        
        display("x_old: " + x + ", diff: " + diff + ", C: " + diff/(olddiff).^2 + ", : Convergence: " +  log10(diff)/log10(olddiff))
        x_old = x;

    end

    display(" ")
    roots(i) = x;

end

display(roots)