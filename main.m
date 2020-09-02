%% Description of the state list
%1 - Initialize of variables - f_init()
%2 - Generate and draw elipse - f_generate_elipse()
%3 - Generate pattern of fis with random weight of rules - f_generate_rule_pattern_fis()
%4 - Generate fiss with random weight of rules for x and y coordinates - f_generate_fis_x_y()
%5 - Generate point x and y after kicking - f_kick_point_from_elipse()
%6 - Evaulate fis with rand weight of rules - f_eval_fis_with_r()
%7 - Sorting dominant weight - f_sort_r()
%8 - Make new generation - f_make_g()
%% Main programm
clear;
clear f_generate_fis_x_y f_make_g;
addpath('functions');
addpath('fis');
list_of_function = {@() f_init()
                    @(dt, a, b, n, l_T) f_generate_elipse(dt, a, b, n, l_T)
                    @(f) f_generate_rule_pattern_fis(f)
                    @(a, b, c) f_generate_fis_x_y(a, b, c)
                    @(a, b, c, d, e) f_kick_point_from_elipse(a, b, c, d, e)
                    @(a, b, c, d, e, f, g, i, k, h, m, n) f_eval_fis_with_r(a, b, c, d, e, f, g, i, k, h, m, n)
                    @(a, b, c) f_sort_r(a, b, c)
                    @(a, b, c, d) f_make_g(a, b, c, d)};
state_system = 1;

while 1
    
    switch state_system
        case 1
            tic
            number_of_gen = 0;
            [n, a, b, dt, T, l_T, x0, y0, massive_of_error, massive_of_error_x, massive_of_error_y] = list_of_function{state_system}();
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
            pattern_fis = list_of_function{state_system}(eval(name_of_loading_fis(1:12)));
            generation = 0.01*round(100*rand(5, 250));
            state_system = state_system + 1;
            fprintf('%d state was completed in %d second\n',state_system-1,toc);
        case 4
            tic
            clc;
            temp_size_row_of_weight = size(generation);
            [fis_x, fis_y, number_of_row]=list_of_function{state_system}(pattern_fis,generation, temp_size_row_of_weight(1));
            state_system = state_system + 1;
            fprintf('%d state was completed in %d second\n',state_system-1,toc);
        case 5 
            tic
            clear x y error tau_f_kkng;
            [x, y, error, tau_f_kkng, error_x, error_y] = list_of_function{state_system}(l_T, x0, y0, a, b);
            state_system = state_system + 1;  
            fprintf('%d state was completed in %d second\n',state_system-1,toc);
        case 6
            tic
            error_x = 0;
            error_y = 0;
            if number_of_row == 1  
                [error, x, y, error_x, error_y] = list_of_function{state_system}(tau_f_kkng, l_T, fis_x, fis_y, x, y, error, dt, x0, y0, error_x, error_y);
                massive_of_error(temp_size_row_of_weight(1)) = error;
                massive_of_error_x(temp_size_row_of_weight(1)) = error_x;
                massive_of_error_y(temp_size_row_of_weight(1)) = error_y;
                fprintf('%d state was completed in %d second\n',state_system,toc);
                state_system = 7;
                plot(x0,y0,x,y);
                axis([-a*1.5 a*1.5 -b*1.5 b*1.5]);
                title_for_plot = "Generation: " + int2str(number_of_gen) + " || Number of individ: " + int2str(temp_size_row_of_weight(1));
                title(title_for_plot);
                pause(0.1);
                continue
            else
                [error, x, y, error_x, error_y] = list_of_function{state_system}(tau_f_kkng, l_T, fis_x, fis_y, x, y, error, dt, x0, y0, error_x, error_y);
                massive_of_error(number_of_row-1) = error;
                massive_of_error_x(number_of_row-1) = error_x;
                massive_of_error_y(number_of_row-1) = error_y;
                title_for_plot = "Generation: " + int2str(number_of_gen) + " || Number of individ: " + int2str(number_of_row-1);
                plot(x0,y0,x,y);
                axis([-a*1.5 a*1.5 -b*1.5 b*1.5]);
                title(title_for_plot);
                pause(0.001);
                fprintf('%d state was completed in %d second\n',state_system,toc);
                state_system = 4;
            end
        case 7
            tic
            [massive_of_error,massive_of_error_x,massive_of_error_y, ind_sort_err, ind_sort_err_x, ind_sort_err_y] = list_of_function{state_system}(massive_of_error,massive_of_error_x, massive_of_error_y);
%             log_ind_sort = [log_ind_sort; ind_sort_err];
            state_system = state_system + 1;
            fprintf('%d state was completed in %d second\n',state_system-1,toc);
        case 8 
            tic
            generation = list_of_function{state_system}(ind_sort_err, generation, ind_sort_err_x, ind_sort_err_y);
            number_of_gen = number_of_gen + 1;
            temp_size_m_e = size(generation);
            massive_of_error = zeros(1, temp_size_m_e(1));
            massive_of_error_x = zeros(1, temp_size_m_e(1));
            massive_of_error_y = zeros(1, temp_size_m_e(1));
            state_system = 4;
            fprintf('%d state was completed in %d second\n',state_system-1,toc);
        otherwise
            fprintf('Programm has been end after %d state\n',state_system-1);
            break
    end
   
end