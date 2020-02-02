
temp_x0 = zeros(1,l_T);
temp_y0 = zeros(1,l_T);
T=0:dt:2*n;
for i=1:l_T
    temp_x0(i)=a*cos(pi*T(i)/n);
    temp_y0(i)=b*sin(pi*T(i)/n);
end

ntau = ceil(rand(1)*l_T/4);

x_with_kkd = zeros(1, 481);
y_with_kkd = zeros(1, 481);
    
for i=1:ntau
    x_with_kkd(i)=x0(i);
    y_with_kkd(i)=y0(i);
end

opt = evalfisOptions('OutOfRangeInputValueMessage','none','NoRuleFiredMessage','none','EmptyOutputFuzzySetMessage','none');

kkd_x_value = a*(rand(1)-0.5);
kkd_y_value = b*(rand(1)-0.5);

x_with_kkd(ntau+1) = x_with_kkd(ntau)+kkd_x_value;
y_with_kkd(ntau+1) = y_with_kkd(ntau)+kkd_y_value;

%error = abs(x_with_kkd(ntau+1)-x0(ntau+1)+y_with_kkd(ntau+1)-y0(ntau+1));

x_after_kkd = x_with_kkd;
y_after_kkd = x_with_kkd;

for i=ntau+2:l_T
    ex=x_after_kkd(i-1)-x_after_kkd(i-2);
    dex=ex/dt;
    ux = evalfis(fis_x, [ex, dex], opt);
    x_after_kkd(i)=x_after_kkd(i-1)+ux;
    
    ey=y_after_kkd(i-1)-y_after_kkd(i-2);
    dey=ey/dt;
    uy = evalfis(fis_y, [ey, dey], opt);
    y_with_kkd(i)=y_with_kkd(i-1)+uy;
    error=error+abs(x_after_kkd(i)-x0(i)+abs(y_after_kkd(i)-y0(i)));
    plot(x0,y0,x_after_kkd,y_after_kkd);
end


% plot(x_after_kkd,y_after_kkd);
axis equal;