variables.error_x_for_check = 0;
variables.error_y_for_check = 0;
variables.error_for_check = 0;

indexs_of_maybe_normally = variables.sorting_index_of_rules_to_best(1:10);

training_data_for_anfis_of_x0(1, :) = variables.x0;
training_data_for_anfis_of_y0(1, :) = variables.y0;
training_data_for_anfis_of_x0(2, :) = variables.x0;
training_data_for_anfis_of_y0(2, :) = variables.y0;

for j=2:2
    variables.row_for_check = indexs_of_maybe_normally(j);
    % variables.row_for_check = variables.row_for_check + 1;

    rand_weigths_of_fis_x = ...
        num2cell(variables.generation ... 
        (variables.row_for_check, 1:125));
    rand_weigths_of_fis_y = ...
        num2cell(variables.generation ...
        (variables.row_for_check, 126:250));

    variables.fis_of_x_for_check = variables.pattern_of_fis;
    variables.fis_of_y_for_check = variables.pattern_of_fis;

    [variables.fis_of_x_for_check.Rules.Weight] = ...
        deal(rand_weigths_of_fis_x{:});
    [variables.fis_of_y_for_check.Rules.Weight] = ...
        deal(rand_weigths_of_fis_y{:});

    variables.kkntau_for_check = ceil(rand(1)*variables.l_T/4);

    variables.x_with_kkd_for_check = zeros(1, variables.kkntau_for_check);
    variables.y_with_kkd_for_check = zeros(1, variables.kkntau_for_check);

    for i=1:variables.kkntau_for_check
        variables.x_with_kkd_for_check(i) = variables.x0(i);
        variables.y_with_kkd_for_check(i) = variables.y0(i);
    end

    variables.kkd_x_value_for_check = variables.a * (rand(1) - 0.5);
    variables.kkd_y_value_for_check = variables.b * (rand(1) - 0.5);

    variables.x_with_kkd_for_check(variables.kkntau_for_check + 1) = ...
     variables.x_with_kkd_for_check(variables.kkntau_for_check) + variables.kkd_x_value_for_check;
    variables.y_with_kkd_for_check(variables.kkntau_for_check + 1) = ...
     variables.y_with_kkd_for_check(variables.kkntau_for_check) + variables.kkd_y_value_for_check;


    for i=variables.kkntau_for_check + 2:variables.l_T
        variables.ex_for_check = variables.x_with_kkd_for_check(i - 1) - variables.x0(i - 1);
        variables.dex_for_check = variables.ex_for_check/variables.dt;
        variables.ux_for_check = evalfis(variables.fis_of_x_for_check, ...
                              [variables.ex_for_check, variables.dex_for_check], ...
                               variables.opt);
        variables.x_with_kkd_for_check(i) = variables.x_with_kkd_for_check(i - 1) + variables.ux_for_check;
        variables.error_x_for_check = ...
            variables.error_x_for_check + abs(variables.x_with_kkd_for_check(i) - variables.x0(i));
        
        training_data_for_anfis_of_x0(1,i) = variables.x_with_kkd_for_check(i);
        training_data_for_anfis_of_x0(2,i) = variables.x0(i);
        
        variables.ey_for_check = variables.y_with_kkd_for_check(i - 1) - variables.y0(i - 1);
        variables.dey_for_check = variables.ey_for_check/variables.dt;
        variables.uy_for_check = evalfis(variables.fis_of_y_for_check, ...
                              [variables.ey_for_check, variables.dey_for_check], ...
                               variables.opt);
        variables.y_with_kkd_for_check(i) = variables.y_with_kkd_for_check(i - 1) + variables.uy_for_check;
        variables.error_y_for_check = ...
            variables.error_y_for_check + abs(variables.y_with_kkd_for_check(i) - variables.y0(i));

        training_data_for_anfis_of_y0(1,i) = variables.y_with_kkd_for_check(i);
        training_data_for_anfis_of_y0(2,i) = variables.y0(i);
        
        variables.error_for_check = ... 
            variables.error_for_check + ...
            abs(variables.x_with_kkd_for_check(i) - variables.x0(i)) +  ...
            abs(variables.y_with_kkd_for_check(i) - variables.y0(i));

    end

    plot(variables.x0, variables.y0,variables.x_with_kkd_for_check, variables.y_with_kkd_for_check);
    axis([-variables.a*1.5 variables.a*1.5 -variables.b*1.5 variables.b*1.5]);
    title(string(variables.row_for_check))
    
end