function variables = s4_kick_point_from_ellipse(variables)
tic
global states_of_machine;

variables.kkntau = ceil(rand(1)*variables.l_T/4);

variables.x_with_kkd = zeros(1, variables.kkntau);
variables.y_with_kkd = zeros(1, variables.kkntau);

for i=1:variables.kkntau
    variables.x_with_kkd(i) = variables.x0(i);
    variables.y_with_kkd(i) = variables.y0(i);
end

variables.kkd_x_value = variables.a * (rand(1) - 0.5);
variables.kkd_y_value = variables.b * (rand(1) - 0.5);

variables.x_with_kkd(variables.kkntau + 1) = ...
 variables.x_with_kkd(variables.kkntau) + variables.kkd_x_value;
variables.y_with_kkd(variables.kkntau + 1) = ...
 variables.y_with_kkd(variables.kkntau) + variables.kkd_y_value;

variables.error = 0;
variables.error_x = 0;
variables.error_y = 0;

variables.previous_state = variables.current_state;
variables.current_state = states_of_machine.s5_eval_fis;

end