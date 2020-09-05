function variables = s7_make_new_generation(variables)
tic
global states_of_machine;

if isfield(variables, 'dominant_part_of_new_generation') ~= 1
   variables.previous_best(1, :) = ...
       variables.generation(variables.sorting_index_of_rules_to_best(1, 1),:);
   variables.dominant_part_of_new_generation = 0.01*round(100*rand(100, 250));
   for i=1:4
       variables.dominant_part_of_new_generation(i, :) =  zeros(1,250);
   end
   for i=1:3
       variables.idle_of_best_individ(i,:) = zeros(1,250);
   end
else
    variables.previous_best(1, :) = variables.dominant_part_of_new_generation(1, :);
end

for i=1:4
    variables.dominant_part_of_new_generation(i,:) = ...
        variables.generation(variables.sorting_index_of_rules_to_best(1, i),:);
end

for k=1:3    
    for i=(k+1):4
        for j=1:250
            if variables.dominant_part_of_new_generation(k, j) <= variables.dominant_part_of_new_generation(i, j)*1.05 && ...
                    variables.dominant_part_of_new_generation(k, j) >= variables.dominant_part_of_new_generation(i, j)*0.85
                variables.idle_of_best_individ(k, j) = variables.dominant_part_of_new_generation(i, j);
            else 
                if randi([0,1], 1) == 1
                    variables.idle_of_best_individ(k, j) = 0.01*round(100*rand(1));
                else
                    variables.idle_of_best_individ(k, j) = variables.dominant_part_of_new_generation(i, j)*0.55;
                end
            end
        end
    end
end

variables.other_part_of_new_generation = 0.01*round(100*rand(92, 250));

for i=1:250
    variables.other_part_of_new_generation(1,:) = min(1, max(variables.previous_best(1, i), variables.dominant_part_of_new_generation(1, i))*1.2);
    variables.other_part_of_new_generation(2,:) = max(variables.previous_best(1, i), variables.dominant_part_of_new_generation(1, i))*0.6;
    variables.other_part_of_new_generation(3,:) = min(1, min(variables.previous_best(1, i), variables.dominant_part_of_new_generation(1, i))*1.2);
end
    
for j=4:5
    for i=1:125
         variables.other_part_of_new_generation(j, i) = variables.generation(variables.sorting_index_of_rules_to_best_x(1, j-3), i);
         variables.other_part_of_new_generation(j, i+125) = variables.generation(variables.sorting_index_of_rules_to_best_y(1, j-3), i+125);
    end
end


    
for i=6:30
    for j=1:125
        if randi([0,1], 1) == 1
            variables.other_part_of_new_generation(i, j) = variables.dominant_part_of_new_generation(1,j)*0.89;
            variables.other_part_of_new_generation(i, j+125) = variables.dominant_part_of_new_generation(1, j)*0.89;
        else
            variables.other_part_of_new_generation(i, j) = variables.dominant_part_of_new_generation(1, j)*0.35;
            variables.other_part_of_new_generation(i, j+125) = variables.dominant_part_of_new_generation(1, j)*0.35;
        end
    end
end

for i=31:40
    for j=1:250
        if variables.dominant_part_of_new_generation(1, j) <= 1.0 && variables.dominant_part_of_new_generation(1, j) >= 0.6
            variables.other_part_of_new_generation(i, j) = min(1, variables.dominant_part_of_new_generation(1,j)*1.1);
        else
            variables.other_part_of_new_generation(i, j) = variables.dominant_part_of_new_generation(1, j)*0.7;
        end
    end
end


for i=41:45
    variables.other_part_of_new_generation(i, :) = variables.generation(variables.sorting_index_of_rules_to_best(1, i-40),:);
end

for i=41:45
    for j=1:125
        if variables.other_part_of_new_generation(i, j) <= 0.1
            variables.other_part_of_new_generation(i, j) = 0;
        end
    end
end

for i = 46:93
     for j=1:125
        if randi([0,1], 1) == 1
            variables.other_part_of_new_generation(i, j) = variables.dominant_part_of_new_generation(1, j);
            variables.other_part_of_new_generation(i, j+125) = variables.dominant_part_of_new_generation(1,j);
        end
    end
end

variables.generation = [variables.dominant_part_of_new_generation; ...
                        variables.idle_of_best_individ; ...
                        variables.other_part_of_new_generation];

variables.number_of_generation = variables.number_of_generation + 1;
                    
variables.previous_state = variables.current_state;
variables.current_state = states_of_machine.s3_generate_fiss_for_x_y;
end