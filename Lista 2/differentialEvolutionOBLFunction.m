%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Differential Evolution with OBL
% v 0.8
% * Function Parameters
% costFunctionName      - The cost function name.
% searchSpace           - The search space used by the cost function.
% dimensions            - The problem dimension. (default = 2)
% population            - The number of population used. (default = 20)
% maxIter               - The maximum number of iterations. (default = 500)
% threshold             - The minimum threshold to stop the algorithm. (default = 1e-10)
% direction             - ???????????????????????????????????? (default = 1)
% mutationFactor,       - Population mutation factor. (default )
% crossOverRate         - Cross over rate. (default = 0.95)
% oblLimit              - The limit of iterations without a change before the OBL utilization. (default = 40)
% * Function Results    
% bestMinimumValue      - The cost function minimum value found.
% bestMinimumPosition   - The position which the minimum value is found.
% bestMinimumValues     - The cost function minimum value found in each iteration.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [time, bestMinimumValue, bestMinimumPosition, bestMinimumValues] = differentialEvolutionOBLFunction(costFunctionName, searchSpace, dimensions, population, maxIter, threshold, direction, initialMutationFactor, finalMutationFactor, crossOverRate, oblLimit)
	
    % Start to count time.
    tic();

    %% DEFAULT VALUES SETTER
    if nargin < 2
        error('differentialEvolutionOBLFunction requires at least 2 arguments: costFunctionName and seachSpace');
    elseif nargin == 2
        direction = 1;
        dimensions = 2;
        population = 20;
        maxIter = 1000; 
        threshold = 0.01; 
        initialMutationFactor = 1.0;
        finalMutationFactor = 1.35;
        crossOverRate = 0.95;
        oblLimit = 40;
    end

    %% INITIALIZATION
    for j=1:dimensions
        individualPos(:, j) = searchSpace(j, 1) + (searchSpace(j, 2) - searchSpace(j, 1)) * rand(population, 1);
    end
    mutated = zeros(population, dimensions);
    newIndividual = zeros(1, dimensions);
    individualResults = zeros(population, 1);
    bestMinimumValues = [];

    mutationFactor = initialMutationFactor;
    deltaMutation = abs(initialMutationFactor + finalMutationFactor) / maxIter;

    % OBL Counter
    oblCounter = 0;

    %% ITERATIVE
    for i=1:maxIter
        % for each individual
        for j = 1:population
            % Mutation
            rev = randperm(population,3);       %Create a list of random integers numbers between 1 and Xpop.
            mutated(j,:)= individualPos(rev(1,1),:) + mutationFactor*(individualPos(rev(1,2),:) - individualPos(rev(1,3),:));

            % Check if the mutated element is beyond the matrix
            beyondInd = mutated(j, :) < searchSpace(:, 1)';
            mutated(j, beyondInd) = searchSpace(beyondInd, 1)';
            beyondInd = mutated(j, :) > searchSpace(:, 2)';
            mutated(j, beyondInd) = searchSpace(beyondInd, 2)';

            % Crossover 
            for k = 1:dimensions
                randomValue = rand(1);
                if randomValue < crossOverRate
                    newIndividual(1,k) = mutated(j,k);
                else
                    newIndividual(1,k) = individualPos(j,k);
                end
            end

            % Selection
            % and Evaluate
            newResult = costFunction(costFunctionName, newIndividual(1,:)');
            oldResult = costFunction(costFunctionName, individualPos(j,:)');
            if newResult < oldResult
                individualPos(j,:) = newIndividual(1,:);
                individualResults(j , 1) = newResult;
            else
                individualResults(j , 1) = oldResult;
            end
        end

        % Select the lowest fitness value
        [results, indexes] = sort(individualResults, 1);
        result_min = results(1,1);
        [bestMinimumValue, index] = min(individualResults);
        bestMinimumValues = [bestMinimumValues bestMinimumValue];
        bestMinimumPosition = individualPos(index, :);

        % Shake Particles with OBL
        if (i ~= 1 && bestMinimumValues(i) == bestMinimumValues(i-1))
            oblCounter = oblCounter + 1;
            if (oblCounter == oblLimit)
                oblCounter = 0;
                numberRandomDimensions = floor(dimensions * rand()) + 1; % Number of random dimensions
                randIndex = floor(dimensions * rand(numberRandomDimensions)) + 1;
                randIndex = unique(randIndex);

                individualPos(:, randIndex) = -individualPos(:, randIndex) + 0.1 * rand();
                outsideIndexes = individualPos(:, randIndex) > searchSpace(randIndex, 2)';
                individualPos(outsideIndexes) = min(searchSpace(:, 2));
            end
        end
    end

    time = toc();
