function y = DTLZ2_3obj(x)
% Objective function : Test problem 'DTLZ2'.
%*************************************************************************


y = [0, 0, 0];

g = sum((x(3:end)-0.5).^2);

y(1) = (1+g) * cos(x(1)*pi/2) * cos(x(2)*pi/2);
y(2) = (1+g) * cos(x(1)*pi/2) * sin(x(2)*pi/2);
y(3) = (1+g) * sin(x(1)*pi/2);




