function [temp_fis_x, temp_fis_y, temp_r]=f_generate_fis_x_y(temp_fis,temp_rand_weight)

persistent temp_z;

if isempty(temp_z)
    temp_z = 1;
end


temp_fis_x=temp_fis;
temp_fis_y=temp_fis;

for i=1:125
    temp_fis_x.Rules(i).Weight = temp_rand_weight(temp_z, i);
    temp_fis_y.Rules(i).Weight = temp_rand_weight(temp_z, i+125);
temp_r = temp_z;
temp_z = temp_z + 1;
end
end