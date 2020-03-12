function [n, a, b, dt, T, l_T, x0, y0, massive_of_error, massive_of_error_x, massive_of_error_y]=f_init()

n = 24; 
a = 6; 
b = 8;
dt = 0.1;
T=0:dt:2*n;

l_T = length(T);

x0 = zeros(1,l_T);
y0 = zeros(1,l_T);

massive_of_error = zeros(1,5);
massive_of_error_x = zeros(1,5);
massive_of_error_y = zeros(1,5);
end

