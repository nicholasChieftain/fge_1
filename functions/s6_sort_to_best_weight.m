function variables = s6_sort_to_best_weight(variables)
tic
global states_of_machine;

variables.sorting_index_of_rules_to_best = zeros(size(variables.massive_of_error)); 
variables.sorting_index_of_rules_to_best_x = zeros(size(variables.massive_of_error_x)); 
variables.sorting_index_of_rules_to_best_y = zeros(size(variables.massive_of_error_y)); 

[variables.massive_of_error, variables.sorting_index_of_rules_to_best] = ...
    sort(variables.massive_of_error, 'ascend');
[variables.massive_of_error_x, variables.sorting_index_of_rules_to_best_x] =  ... 
    sort(variables.massive_of_error_x, 'ascend');
[variables.massive_of_error_y, variables.sorting_index_of_rules_to_best_y] =  ...
    sort(variables.massive_of_error_y, 'ascend');

file_id = fopen(variables.name_of_file_for_log_massive_of_error, 'a');
fprintf(file_id, '%f; ', variables.massive_of_error);
fprintf(file_id, '\n');
fclose(file_id);

variables.previous_state = variables.current_state;
variables.current_state = states_of_machine.s7_make_new_generation;
end
