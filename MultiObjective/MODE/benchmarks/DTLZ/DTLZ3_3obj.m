function y = DTLZ3_3obj(x)
% Objective function : Test problem 'DTLZ2'.
%*************************************************************************


y = [0, 0, 0];
N= size(x,2);
k = 5;
g = 100*(k + sum((x(N-k+1:end)-0.5).^2 - cos(20*pi*(x(N-k+1:end)-0.5)) ) );

y(1) = (1+g) * cos(x(1)*pi/2) * cos(x(2)*pi/2);
y(2) = (1+g) * cos(x(1)*pi/2) * sin(x(2)*pi/2);
y(3) = (1+g) * sin(x(1)*pi/2);



% codigo matlab DTLZ benchmarks
% http://www.geatbx.com/ver_3_7/mobjdtlz1.html
% http://www.geatbx.com/ver_3_7/mobjdtlz2.html
% http://www.geatbx.com/ver_3_7/mobjdtlz3.html
% http://www.geatbx.com/ver_3_7/mobjdtlz4.html
% http://www.geatbx.com/ver_3_7/mobjdtlz5.html
% http://www.geatbx.com/ver_3_7/mobjdtlz6.html

% fronteiras de pareto ZDT e DTLZ benchmarks
% http://jmetal.sourceforge.net/problems.html

% informacao geral sobre benchmark otimizacao
% https://en.wikipedia.org/wiki/Test_functions_for_optimization


