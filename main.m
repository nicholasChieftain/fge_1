clear;
addpath('functions');

global states_of_machine
states_of_machine = struct('s1_init', 1, ...
                           's2_gen_pattern_of_fis', 2, ...
                           's3_generate_fiss_for_x_y', 3, ...
                           's4_kick_point_from_ellipse', 4, ...
                           's5_eval_fis', 5, ...
                           's6_sort_to_best_weight', 6, ...
                           's7_make_new_generation', 7, ...
                           's0_end', 0);

name_of_functions = fieldnames(states_of_machine);
          
variables = struct();
variables.current_state = 1;
variables.complete_time = 0;
variables.number_of_generation = 1;
variables.name_of_file_for_log_massive_of_error = ... 
    string(datetime(now,'ConvertFrom', 'datenum')) + '_log_of_errors.txt';
                   
for i=1:size(name_of_functions)
    name_of_functions_of_machine.(name_of_functions{i}) = ...
        str2func(name_of_functions{i});
    clear str2func(name_of_functions{i});
end

while 1
    variables = ...
        name_of_functions_of_machine. ...
        (name_of_functions{variables.current_state})(variables);
    variables.elapsed_to_last_state_time = toc;
    variables.complete_time = variables.complete_time + variables.elapsed_to_last_state_time;
    fprintf('%d state was completed in %d second\r', ...
       variables.previous_state, variables.elapsed_to_last_state_time);
    
    if variables.current_state == states_of_machine.s0_end
        break
    end
end