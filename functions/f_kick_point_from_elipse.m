function [x_with_kkd, y_with_kkd, error, ntau, error_x, error_y] = f_kick_point_from_elipse(l_t, x0, y0, a, b)

ntau = ceil(rand(1)*l_t/4);

x_with_kkd = zeros(1, ntau);
y_with_kkd = zeros(1, ntau);
    
for i=1:ntau
    x_with_kkd(i)=x0(i);
    y_with_kkd(i)=y0(i);
end


kkd_x_value = a*(rand(1)-0.5);
kkd_y_value = b*(rand(1)-0.5);

x_with_kkd(ntau+1) = x_with_kkd(ntau)+kkd_x_value;
y_with_kkd(ntau+1) = y_with_kkd(ntau)+kkd_y_value;

error = 0;
error_x = 0;
error_y = 0;

end