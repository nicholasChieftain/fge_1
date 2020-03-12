function [fis_x, fis_y, temp_r]=f_generate_fis_x_y(temp_fis,temp_rand_weight, temp_size_row_of_weight)

persistent temp_z;
persistent temp_fis_x;
persistent temp_fis_y;

if isempty(temp_z)
    temp_z = 1;
    temp_fis_x=temp_fis;
    temp_fis_y=temp_fis;
end

num_r_weight_x = num2cell(temp_rand_weight(temp_z, 1:125));
num_r_weight_y = num2cell(temp_rand_weight(temp_z, 126:250));

[temp_fis_x.Rules.Weight] = deal(num_r_weight_x{:});
[temp_fis_y.Rules.Weight] = deal(num_r_weight_y{:});

% for i=1:125
% %    temp_fis_x = setfield(temp_fis_x, 'Rules',{i},'Weight', temp_rand_weight(temp_z, i));
% %    temp_fis_y = setfield(temp_fis_y, 'Rules',{i},'Weight', temp_rand_weight(temp_z, i+125));
% %    temp_fis_x.Rules(i).Weight = temp_rand_weight(temp_z, i);
% %    temp_fis_y.Rules(i).Weight = temp_rand_weight(temp_z, i+125);
%     temp_fis_x.Rules(i).Weight = num_r_weight(1, i);
%     temp_fis_y.Rules(i).Weight = num_r_weight(1, i+125);
%     [temp_fis_x.Rules.Weight]=deal(num_r_weight{:})
% end
 
fis_x = temp_fis_x;
fis_y = temp_fis_y;

if temp_z == temp_size_row_of_weight   
    temp_z = 1;    
else
    temp_z = temp_z + 1;
end

temp_r = temp_z;

end