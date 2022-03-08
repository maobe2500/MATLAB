
% P(x) = 102 + 3x + 2x^2 + x^3
fplot(@(x) 102+3*x+2*x.^2+x.^3)
xlim([0,7])
xlabel('x values')
ylabel('y values')
title('Beast Graph')