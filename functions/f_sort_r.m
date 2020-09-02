function [mas_er,mas_er_x,mas_er_y, index_of_sorting_dominant_rule, index_of_sorting_dominant_rule_x, index_of_sorting_dominant_rule_y] = f_sort_r(mas_er, mas_er_x, mas_er_y)
persistent ind_rule 
persistent ind_rule_x
persistent ind_rule_y



ind_rule = zeros(size(mas_er)); 
ind_rule_x = zeros(size(mas_er)); 
ind_rule_y = zeros(size(mas_er)); 

[mas_er, ind_rule] = sort(mas_er, 'ascend');
[mas_er_x, ind_rule_x] = sort(mas_er_x, 'ascend');
[mas_er_y, ind_rule_y] = sort(mas_er_y, 'ascend');

index_of_sorting_dominant_rule = ind_rule;
index_of_sorting_dominant_rule_x = ind_rule_x;
index_of_sorting_dominant_rule_y = ind_rule_y;

end

