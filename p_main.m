%% Description of the state list
%1 - Initialize of variables - f_init()
%2 - Generate and draw elipse - f_generate_elipse()
%3 - Generate pattern of fis with random weight of rules - f_generate_rule_pattern_fis()
%4 - Generate fiss with random weight of rules for x and y coordinates - f_generate_fis_x_y()
%5 - Generate point x and y after kicking - f_kick_point_from_elipse()

%% Main programm

list_of_function = {@() f_init()
                    @(dt, a, b, n, l_T) f_generate_elipse(dt, a, b, n, l_T)
                    @(f) f_generate_rule_pattern_fis(f)
                    @(a, b) f_generate_fis_x_y(a, b)
                    @(a, b, c, d, e) f_kick_point_from_elipse()};
state_system = 5;

while 1
    
    switch state_system
        case 1
            clear;
            tic
            [n, a, b, dt, T, l_T, x0, y0] = list_of_function{state_system}();
            state_system = state_system + 1;
            fprintf('%d state was completed in %d second\n',state_system-1,toc);
        case 2
            tic
            [x0, y0] = list_of_function{state_system}(dt, a, b, n, l_T);
            state_system = state_system + 1;
            fprintf('%d state was completed in %d second\n',state_system-1,toc);
        case 3
            tic
            name_of_loading_fis = 'elipse_fis_1.mat';
            load(name_of_loading_fis);
            pattern_fis = list_of_function{3}(eval(name_of_loading_fis(1:12)));
            rand_weight = 0.01*round(100*rand(200, 250));
            state_system = state_system + 1;
            fprintf('%d state was completed in %d second\n',state_system-1,toc);
        case 4
            tic
            [fis_x, fis_y, number_of_row]=list_of_function{state_system}(pattern_fis,rand_weight);
            if number_of_row == 200
                break
            end
            state_system = state_system + 1;
            fprintf('%d state was completed in %d second\n',state_system-1,toc);
        case 5 
            tic
            [x, y, error, tau_f_kkng] = list_of_function{state_system}(l_T, x0, y0, a, b);
            state_system = state_system + 1;
            fprintf('%d state was completed in %d second\n',state_system-1,toc);
        otherwise
            fprintf('Programm has been end after %d state\n',state_system-1,toc);
            break
    end
   
end