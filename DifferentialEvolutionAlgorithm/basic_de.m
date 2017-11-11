function [out] = basic_de(M,N,funcao)

	close all
    %clear all
	clc

	%Common Parameter Setting
	%N=10; 		% Number of variables
	%M=50; 		% Populations size
	F=1.25; 		% Mutation factor
	C=0.95; 		% Crossover rate
	I_max=500; 	% Max iteration time
    Run=1;      % The number of test time
% 	X_max=5.12;
% 	X_min=-5.12;

    % Range domain for fitness function
    if (funcao == 5) % Schwefel
       X_min = -500;
       X_max =  500;
    elseif (funcao == 6) %Ackley
       X_min = -32;
       X_max =  32;
    elseif (funcao == 6) %Michalewicz
       X_min = -0;
       X_max =  pi;       
    else
       X_min = -8;
       X_max =  8;
    end
       
    switch funcao
    case 1
        Func=@sphere; 
    case 2
        Func=@quadric; 
    case 3
        Func=@rosenbrock; 
    case 4
        Func=@rastrigin; 
    case 5
        Func=@schwefel; 
    case 6
        Func=@ackley; %% trocar para funcao Michalewicz
    otherwise
        disp('invalid function');
    end

	% 2.The whole test loop
    for r=1:Run
        iter=0;
        % 1.Generate MxN matrix (Initial Population)
        X = zeros(M,N);
        for m=1:M
            for n=1:N
                X(m,n)=X_min+rand()*(X_max-X_min);
            end
        end
        
        for i=1:I_max  % Stop when the iteration large than the max iteration time
            iter=iter+1;
            for m=1:M % For each individual
                % Mutation
				[V]=rand1(X,M,F,m);
                % Check if the element in the V matrix beyond the boundary.
                for n=1:N
                    if V(1,n)>X_max
                        V(1,n)=X_max;
                    end
                    if V(1,n)<X_min
                        V(1,n)=X_min;
                    end
                end

                % Crossover put the result in the U matrix
                jrand=floor(rand()*N+1);
                for n=1:N
                    R1=rand();
                    if (R1<C || n==jrand)
                        U(1,n)=V(1,n);
                    else
                        U(1,n)=X(m,n);
                    end
                end

                % Selection
                if Func(U(1,:)) < Func(X(m,:))
                    Tr=U(1,:);
                else
                    Tr=X(m,:);
                end
                % Use the selection result to replace the m row
                X(m,:)=Tr;
                % Evaluate each individual's fitness value, and put the result in the Y matrix.
                Y(m,1)=Func(X(m,:));

            end % Now the 1th individual generated
            % Select the lowest fitness value
            [y,ind1]=sort(Y,1);
            Y_min=y(1,1);
            [Ymin,ind] = min(Y);
            
            % plot the picture of iteration
            figure(3);
            plot(iter,Ymin,'r.');
            xlabel('Iteration');
            ylabel('Fitness');
            title(sprintf('Iteration=%d, Fitness=%9.9f',i,Ymin));
            grid on;
            hold on;
        end % Finish I_max times iteration
	    
% 		hold off;
%         PlotR();
%         hold on;
%         scatter3(X(ind,1),X(ind,1),Ymin,'fill','ro');

    end % Run times
    
    out = Ymin;