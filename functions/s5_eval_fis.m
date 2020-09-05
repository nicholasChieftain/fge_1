function variables = s5_eval_fis(variables)
tic
global states_of_machine;

if isfield(variables, 'dex') ~= 1
    variables.dex = 0;
    variables.dey = 0;
    variables.ux = 0;
    variables.uy = 0;
    variables.ex = 0;
    variables.opt = evalfisOptions('OutOfRangeInputValueMessage', ...
                         'none', ...
                         'NoRuleFiredMessage', ...
                         'none', ...
                         'EmptyOutputFuzzySetMessage', ... 
                         'none');
end

for i=variables.kkntau + 2:variables.l_T
    variables.ex = variables.x_with_kkd(i - 1) - variables.x0(i - 1);
    variables.dex = variables.ex/variables.dt;
    variables.ux = evalfis(variables.fis_of_x, ...
                          [variables.ex, variables.dex], ...
                           variables.opt);
    variables.x_with_kkd(i) = variables.x_with_kkd(i - 1) + variables.ux;
    variables.error_x = ...
        variables.error_x + abs(variables.x_with_kkd(i) - variables.x0(i));
    
    variables.ey = variables.y_with_kkd(i - 1) - variables.y0(i - 1);
    variables.dey = variables.ey/variables.dt;
    variables.uy = evalfis(variables.fis_of_y, ...
                          [variables.ey, variables.dey], ...
                           variables.opt);
    variables.y_with_kkd(i) = variables.y_with_kkd(i - 1) + variables.uy;
    variables.error_y = ...
        variables.error_y + abs(variables.y_with_kkd(i) - variables.y0(i));
    
    variables.error = ... 
        variables.error + ...
        abs(variables.x_with_kkd(i) - variables.x0(i)) +  ...
        abs(variables.y_with_kkd(i) - variables.y0(i));
    
end

variables.massive_of_error(variables.current_row_of_gen_in_work) = variables.error;
variables.massive_of_error_x(variables.current_row_of_gen_in_work) = variables.error_x;
variables.massive_of_error_y(variables.current_row_of_gen_in_work) = variables.error_y;

plot(variables.x0, variables.y0,variables.x_with_kkd, variables.y_with_kkd);
axis([-variables.a*1.5 variables.a*1.5 -variables.b*1.5 variables.b*1.5]);
title_for_plot = "Generation: " + int2str(variables.number_of_generation) + " || Number of individ: " + int2str(variables.current_row_of_gen_in_work);
title(title_for_plot)
pause(0.001);

if variables.current_row_of_gen_in_work == ... 
        variables.num_of_row_of_generation   
    variables.next_row_of_gen_in_work = 1;
    variables.previous_state = variables.current_state;
    variables.current_state = states_of_machine.s6_sort_to_best_weight;
else
    variables.next_row_of_gen_in_work = ... 
        variables.current_row_of_gen_in_work + 1;
    variables.previous_state = variables.current_state;
    variables.current_state = states_of_machine.s3_generate_fiss_for_x_y;
end

end