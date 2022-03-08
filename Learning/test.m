b = ones(3, 10);
b(:,1) = [3 5 6]';
c = b(:,1) > 4
if c
    display(b);
end
