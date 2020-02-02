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
% clear;
% clear f_generate_fis_x_y f_make_g;
% addpath('/Users/nicholas_chieftain/Учеба/fge_1/functions');
% addpath('/Users/nicholas_chieftain/Учеба/fge_1/fis');
list_of_function = {@() f_init()
                    @(dt, a, b, n, l_T) f_generate_elipse(dt, a, b, n, l_T)
                    @(f) f_generate_rule_pattern_fis(f)
                    @(a, b, c) f_generate_fis_x_y(a, b, c)
                    @(a, b, c, d, e) f_kick_point_from_elipse(a, b, c, d, e)
                    @(a, b, c, d, e, f, g, i, k, h) f_eval_fis_with_r(a, b, c, d, e, f, g, i, k, h)
                    @(a) f_sort_r(a)
                    @(a, b) f_make_g(a, b)};
state_system = 4;

while 1
    
    switch state_system
        case 1
            tic
            number_of_gen = 0;
            [n, a, b, dt, T, l_T, x0, y0, massive_of_error] = list_of_function{state_system}();
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
            temp_size_row_of_weight = size(generation);
            [fis_x, fis_y, number_of_row]=list_of_function{state_system}(pattern_fis,generation, temp_size_row_of_weight(1));
            state_system = state_system + 1;
            fprintf('%d state was completed in %d second\n',state_system-1,toc);
        case 5 
            tic
            clear x y error tau_f_kkng;
            [x, y, error, tau_f_kkng] = list_of_function{state_system}(l_T, x0, y0, a, b);
            state_system = state_system + 1;  
            fprintf('%d state was completed in %d second\n',state_system-1,toc);
        case 6
            tic
            if number_of_row == 1  
                [error, x, y] = list_of_function{state_system}(tau_f_kkng, l_T, fis_x, fis_y, x, y, error, dt, x0, y0);
                massive_of_error(temp_size_row_of_weight(1)) = error;
                fprintf('%d state was completed in %d second\n',state_system,toc);
                state_system = 7;
                plot(x0,y0,x,y);
                title_for_plot = "Generation: " + int2str(number_of_gen) + " || Number of individ: " + int2str(temp_size_row_of_weight(1));
                title(title_for_plot);
                pause(0.1);
                continue
            else
                [error, x, y] = list_of_function{state_system}(tau_f_kkng, l_T, fis_x, fis_y, x, y, error, dt, x0, y0);
                massive_of_error(number_of_row-1) = error;

                title_for_plot = "Generation: " + int2str(number_of_gen) + " || Number of individ: " + int2str(number_of_row-1);
                plot(x0,y0,x,y);
                title(title_for_plot);
                pause(0.1);
                fprintf('%d state was completed in %d second\n',state_system,toc);
                state_system = 4;
            end
        case 7
            tic
            [massive_of_error, ind_sort_err] = list_of_function{state_system}(massive_of_error);
            %log_ind_sort = [log_ind_sort; ind_sort_err];
            state_system = state_system + 1;
            fprintf('%d state was completed in %d second\n',state_system-1,toc);
        case 8 
            tic
            generation = list_of_function{state_system}(ind_sort_err, generation);
            number_of_gen = number_of_gen + 1;
            temp_size_m_e = size(generation);
            massive_of_error = zeros(1, temp_size_m_e(1));
            state_system = 4;
            fprintf('%d state was completed in %d second\n',state_system-1,toc);
        otherwise
            fprintf('Programm has been end after %d state\n',state_system-1);
            break
    end
   
end