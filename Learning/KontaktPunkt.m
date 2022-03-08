

%% a) Härled längden L av bandet som en funktion av X
% MATH



%% b) Skriv en funktion som ritar upp cirklarna så som i figuren
% Låt r = 0.25, xc = 1.2, och yc = 2.0. 
% Skriv en funktion som givet xc och r, ritar upp cirklarna så som i figuren.


%% c) Skriv en Matlab-funktion Kontaktpunkt.m som löser ekvationsystemet F(x,y,a) = 0
% med Newtons metod och returnerar kontaktpunkten. Programmet ska beräkna och
% skriva ut lösningen (koordinaterna) med ett fel mindre än 10−10. Det är viktigt att
% Jacobian-matrisen beräknas korrekt för att Newtons metod ska fungera och ge kvadratisk
% konvergens. Som hjälp kan ni kolla att


% Variables
Xc = [1.2,2];
r = 0.25; 
step_size = 0.001;


[root] = Newton(1.21, Xc, r);
display(root);

v = VideoWriter('matlab.mp4', 'MPEG-4');
open(v);

frame = 1;
for i = 3:-0.01:1.21    

    % Draws the circles
    Draw(Xc, r, frame)
    
    % Caclulate the roots for current L value
    [root] = Newton(i, Xc, r);
    x = [-root(1):step_size:root(1)];   % We only want to draw from/to the contact point
    h = root(2) - root(3)*cosh(root(1)/root(3));
    y = h + root(3)*cosh(x/root(3));
    plot(x, y);

    % Axis constraints
    xlim([-2 2])
    ylim([-0.4 3])
   
    % Get the frame and save in vector
    axis off;
    f = getframe;
    M(frame) = f;
    frame = frame + 1;
    writeVideo(v, f);
    hold off;
end



close(v);

%% d) Utvidga programmet så att det även plottar spolarna och bandet i en figur.

%% e) Använd en for-loop för att variera L mellan valfritt stort värde och 1.2. 
% Programmet ska visa en animation av hur bandet lindas upp.




%% Functions


function void = Draw(Xc, r, frame)

    % Define the two circles
    p1 = nsidedpoly(1000, 'Center', [Xc(1), Xc(2)], 'Radius', r);
    p2 = nsidedpoly(1000, 'Center', [-Xc(1), Xc(2)], 'Radius', r);

    % Make two square holes that spin 
    hole1 = nsidedpoly(4, 'Center', [Xc(1), Xc(2)], 'SideLength', r/2);
    hole2 = nsidedpoly(4, 'Center', [-Xc(1), Xc(2)], 'SideLength', r/2);
    spun_hole1 = rotate(hole1, frame.*2, [Xc(1), Xc(2)]);
    spun_hole2 = rotate(hole2, -frame.*2, [-Xc(1), Xc(2)]);
    
    %Plot the two circles
    axis equal;
    plot(p1, 'FaceColor', 'k');
    hold on;
    plot(p2, 'FaceColor', 'k');
    hold on;
    
    % Plot the squares on top
    h1 = plot(spun_hole1, 'FaceColor', 'w');
    h1.FaceAlpha = 1;
    hold on;
    h2 = plot(spun_hole2, 'FaceColor', 'w');
    h2.FaceAlpha = 1;
    hold on;

end
    

function [root] = Newton(L, Xc, r)
    
    % Function and jacobian definition
    F = @(x,y,a) [ (x - Xc(1)).^2 + (y - Xc(2)).^2 - r.^2 ;
                    x - Xc(1) + (y - Xc(2)).*sinh(x/a)  ;
                    a * sinh(x/a) - L                  ];

    J = @(x, y, a) [    2*x-2*Xc(1)              2*y-2*Xc(2)                 0              ;
                    1+(y-Xc(2))*cosh(x/a)*1/a     sinh(x/a)      (Xc(2)-y)*cosh(x/a)*x/a^2 ;
                          cosh(x/a)                      0         sinh(x/a)-cosh(x/a)*x/a    ];

    % Variables
    Tol = 1e-10;
    X0 = [1; 1; 1];
    X = X0;
    X_old = X0;
    max_iter = 50;
    err = ones(3, max_iter);
    for iter = 1:max_iter
        
        Func = F(X(1), X(2), X(3));
        Jacobian = J(X(1), X(2), X(3));
        
        X = X - Jacobian \ Func;
        
        % If each of the current errors are less than Tol we're done
        err(:,iter) = abs(X - X_old);
        X_old = X;
        if err(:,iter) < Tol
            break;
        end
    end

    % The returned vector containing the roots
    root = [X(1), X(2), X(3)];
    
end