clear;
flag_first_run = 1; %Uncomment if running programm at first and comment if running not at firts

list_of_function = {@(a, b, c, d, t) f_generate_elipse(a, b, c, d, t)};


if flag_first_run
%% Initialize variable    
    state = 1;
    n = 24; 
    a = 6; 
    b = 8;
    dt = 0.1;
    T=0:dt:2*n;

    l_T = length(T);

    x0 = zeros(1,l_T);
    y0 = zeros(1,l_T);

%% Generate elipse
    x0_y0 = list_of_function{state}(dt, a, b, n, l_T);
    
    x0 = x0_y0(1, :);
    y0 = x0_y0(2, :);

    flag_first_run = 0;
    plot(x0,y0);
    axis equal;
    state = state + 1;
end


% ntau = ceil(rand(1)*l_T/4);
% 
% clear x y;
% 
% %x = zeros(1,ceil(l_T/4));
% %y = zeros(1,ceil(l_T/4));
% 
% for i=1:ntau
%     x(i)=x0(i);
%     y(i)=y0(i);
% end
% 
% 
% s0x = a*(rand(1)-0.5);
% s0y = b*(rand(1)-0.5);
% 
% x(ntau+1) = x(ntau)+s0x;
% y(ntau+1) = y(ntau)+s0y;
% 
% q = abs(x(ntau+1)-x0(ntau+1)+y(ntau+1)-y0(ntau+1));
% 
% for i=ntau+2:l_T
%     ex=x(i-1)-x(i-2);
%     dex=ex/dt;
%     ux = evalfis([ex, dex],elipse_fis_2_x);
%     x(i)=x(i-1)+ux;
%     
%     ey=y(i-1)-y(i-2);
%     dey=ey/dt;
%     uy = evalfis([ey, dey],elipse_fis_2_y);
%     y(i)=y(i-1)+uy;
%     q=q+abs(x(i)-x0(i)+abs(y(i)-y0(i)));
% end
% 
% %plot(x0,y0,x,y,'r');
% axis equal