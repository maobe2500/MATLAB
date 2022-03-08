
format long


%Guesses
x_guess = [1.9 3.9 6.0];
roots = [1 1 1];

%Function
g = @(x) 1/20.*x.^2 + 11/20.*x - 3/5*sin(3.*x+1) + 1;

% Calculate the root for each of the guesses
for i = 1 : length(x_guess)
    
    x_old = x_guess(i);
    TOL = 10e-10;
    diff = 1;

    while diff > TOL
        x = g(x_old);
        olddiff = diff;
        diff = abs(x - x_old);
        
        x_old = x;

        display("x_n: " + x_old + ", C: " + diff/olddiff + ", : Convergence: " +  log10(diff)/log10(olddiff))
    end

    disp(" ")
    roots(i) = x;

end

display(roots)