% c) Skriv en Matlab-funktion Kontaktpunkt.m som löser ekvationsystemet F(x,y,a) = 0
% med Newtons metod och returnerar kontaktpunkten. Programmet ska beräkna och
% skriva ut lösningen (koordinaterna) med ett fel mindre än 10−10. Det är viktigt att
% Jacobian-matrisen beräknas korrekt för att Newtons metod ska fungera och ge kvadratisk
% konvergens. Som hjälp kan ni kolla att

Xc = [1.2,2];
r = 0.25;
L = 1.2; % Halva avståndet mellan cirklarna
Tol = 10e-10;

F = @(x,y,a) [ (x - Xc(1))^2 + (y - Xc(2))^2 - r^2 ;
                x - Xc(1) + (y - Xc(2))*sinh(x/a)  ;
                a * sinh(x/a) - L                  ];

J = @(x, y, a) [    2*x-2*Xc(1)              2*y-2*Xc(2)                 0              ;
                 1+(y-Xc(2))*cosh(x/a)*1/a     sinh(x/a)      (Xc(2)-y)*cosh(x/a)*x/a^2 ;
                    cosh(x/a)                      0         sinh(x/a)-cosh(x/a)*x/a    ];
%X_n+1 = X_n - inv(jacobian(x, y)) * function(x, y);

Jacobian = J(0,0,1);


Tol = 10e-10;
X0 = [2; 1; 2];
X = X0;
X_old = X0;
max_iter = 20;
for i = 1:max_iter
    
    Func = F(X(1), X(2), X(3));
    Jacobian = J(X(1), X(2), X(3));
    
    X = X - Jacobian\Func;
    
    err(:,i) = abs(X - X_old);
    X_old = X;
    if err(:,i) < Tol
        break;
    
    end
end
root = [X(1), X(2), X(3)]
%disp(err(:,i))

h = root(2) - root(3)*cosh(root(1)/root(3));
y = h + root(3)*cosh(x/root(3));



p1 = nsidedpoly(1000, 'Center', [Xc(1) Xc(2)], 'Radius', r);
p2 = nsidedpoly(1000, 'Center', [-Xc(1) Xc(2)], 'Radius', r);
plot(p1, 'FaceColor', 'w')
hold on
plot(p2, 'FaceColor', 'w')
hold on
plot(x, y)
axis equal
