function [mas_er, index_of_sorting_dominant_rule] = f_sort_r(mas_er)
persistent ind_rule


ind_rule = zeros(size(mas_er)); 


[mas_er, ind_rule] = sort(mas_er, 'ascend');

index_of_sorting_dominant_rule = ind_rule;

end

