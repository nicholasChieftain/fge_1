function variables = s1_init(variables)
tic
global states_of_machine;
variables.a = 6;
variables.b = 8;
variables.n = 24;
variables.dt = 0.1;
variables.T = 0:variables.dt:2*variables.n;
variables.l_T = length(variables.T);
variables.x0 = zeros(1, variables.l_T);

for i=1:variables.l_T
    variables.x0(i) = variables.a*cos(pi*variables.T(i)/variables.n);
    variables.y0(i) = variables.b*sin(pi*variables.T(i)/variables.n);
end

plot(variables.x0, variables.y0);
axis equal;

variables.massive_of_error = zeros(1, 5);
variables.massive_of_error_x = zeros(1, 5);
variables.massive_of_error_y = zeros(1, 5);

variables.previous_state = variables.current_state;
variables.current_state = states_of_machine.s2_gen_pattern_of_fis;
end