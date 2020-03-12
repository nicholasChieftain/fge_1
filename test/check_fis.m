
check_x0 = zeros(1,l_T);
check_y0 = zeros(1,l_T);

check_T=0:dt:2*n;

for i=1:l_T
    check_x0(i)=a*cos(pi*check_T(i)/n);
    check_y0(i)=b*sin(pi*check_T(i)/n);
end

check_ntau = ceil(rand(1)*l_T/4);

check_x_with_kkd = zeros(1, 481);
check_y_with_kkd = zeros(1, 481);
    
for i=1:check_ntau
    check_x_with_kkd(i)=check_x0(i);
    check_y_with_kkd(i)=check_y0(i);
end

check_fix_x = fis_x;
check_fis_y = fis_y;

check_wx = num2cell(templ_bb(1, 1:125));
check_wy = num2cell(templ_bb(1, 126:250));

[check_fix_x.Rules.Weight] = deal(check_wx{:});
[check_fix_y.Rules.Weight] = deal(check_wy{:});

opt = evalfisOptions('OutOfRangeInputValueMessage','none','NoRuleFiredMessage','none','EmptyOutputFuzzySetMessage','none');

kkd_x_value = a*(rand(1)-0.5);
kkd_y_value = b*(rand(1)-0.5);

check_x_with_kkd(check_ntau+1) = check_x_with_kkd(check_ntau)+kkd_x_value;
check_y_with_kkd(check_ntau+1) = check_y_with_kkd(check_ntau)+kkd_y_value;


for i=check_ntau+2:l_T
    c_ex=check_x_with_kkd(i-1)-check_x0(i-1);
    c_dex=c_ex/dt;
    c_ux = evalfis(check_fis_x, [c_ex, c_dex], opt);
    check_x_with_kkd(i)=check_x_with_kkd(i-1)+c_ux;
    
    c_ey=check_y_with_kkd(i-1)-check_y0(i-1);
    c_dey=cey/dt;
    c_uy = evalfis(check_fis_y, [cey, c_dey], opt);
    check_y_with_kkd(i)=check_y_with_kkd(i-1)+c_uy;
    %plot(x0,y0,x_after_kkd,y_after_kkd);
end


plot(x0,y0, check_x_with_kkd,check_y_with_kkd);
axis equal;