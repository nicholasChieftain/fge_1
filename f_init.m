function [n, a, b, dt, T, l_T, x0, y0]=f_init()

n = 24; 
a = 6; 
b = 8;
dt = 0.1;
T=0:dt:2*n;

l_T = length(T);

x0 = zeros(1,l_T);
y0 = zeros(1,l_T);

end

