function variables = s3_generate_fiss_for_x_y(variables)
tic
global states_of_machine;

if isfield(variables, 'current_row_of_gen_in_work') ~= 1
    variables.next_row_of_gen_in_work = 1;
    variables.fis_of_x=variables.pattern_of_fis;
    variables.fis_of_y=variables.pattern_of_fis;
    variables.generation = 0.01*round(100*rand(5, 250));
end

variables.num_of_row_of_generation = size(variables.generation);
variables.num_of_row_of_generation = variables.num_of_row_of_generation(1);
variables.current_row_of_gen_in_work = variables.next_row_of_gen_in_work;

rand_weigths_of_fis_x = ...
    num2cell(variables.generation ... 
    (variables.current_row_of_gen_in_work, 1:125));
rand_weigths_of_fis_y = ...
    num2cell(variables.generation ...
    (variables.current_row_of_gen_in_work, 126:250));

[variables.fis_of_x.Rules.Weight] = ...
    deal(rand_weigths_of_fis_x{:});
[variables.fis_of_y.Rules.Weight] = ...
    deal(rand_weigths_of_fis_y{:});

variables.previous_state = variables.current_state;
variables.current_state = states_of_machine.s4_kick_point_from_ellipse;
end

