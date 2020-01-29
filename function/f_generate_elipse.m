function [temp_x0, temp_y0]=f_generate_elipse(temp_dt, temp_a, temp_b, temp_n, temp_l_T)
temp_x0 = zeros(1,temp_l_T);
temp_y0 = zeros(1,temp_l_T);
T=0:temp_dt:2*temp_n;
for i=1:temp_l_T
    temp_x0(i)=temp_a*cos(pi*T(i)/temp_n);
    temp_y0(i)=temp_b*sin(pi*T(i)/temp_n);
end
plot(temp_x0,temp_y0);
axis equal;
end