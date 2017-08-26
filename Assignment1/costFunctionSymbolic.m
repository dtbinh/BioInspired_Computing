%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Assignment 1 - Implementation of benchmark cost functions symbolic.
%
% Function parameters: 
% functionName - The function name as a string.
% dimension - The search space dimension.
% Function results:
% symbolicSpace - As a vector of symbolic variables;
% symbolicFunction - As a symbolic function which depends on the variables in symbolic space;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [symbolicFunction, symbolicSpace] = costFunctionSymbolic(functionName, dimension)
% Symbolic
syms X F
X = sym('x', [1 dimension]);
if functionName == string('sphere')
    F = 0;
    for i=1:dimension
       F = F + X(i)^2;
    end
elseif functionName == string('elliptic')
    F = 0;
    for i=1:dimension
       F = F + (10)^((i - 1)/(dimension - 1)) * X(i)^2; 
    end
elseif functionName == string('rastrigin')
    F = 0;
    for i=1:dimension
       F = F + (X(i)^2 - 10 * cos(2 * pi * X(i)) + 10); 
    end
elseif functionName == string('rosenbrock')
    F = 0;
    for i=1:dimension-1
        F = F + 100 * (X(i)^2 - X(i+1))^2 + (X(i) - 1)^2;
    end
elseif functionName == string('ackley')
    S1 = 0;
    S2 = 0;
    for i=1:dimension
       S1 = S1 + X(i)^2;
       S2 = S2 + cos(2 * pi * X(i));
    end
    F = -20.0 * exp(-0.2 * sqrt(S1 / dimension)) - exp(S2 / dimension) + 20 + exp(1);
elseif functionName == string('schwefel')
    F = 418.9829 * dimension;
    for i=1:dimension
       F = F - X(i) * sin(sqrt(abs(X(i)))); 
    end
else % Quadric
    F = 0;
    for i=1:dimension
       S = 0;
       for j=1:i
           S = S + X(j);
       end
       F = F + S^2;
    end
end
symbolicFunction = F;
symbolicSpace = X;
end