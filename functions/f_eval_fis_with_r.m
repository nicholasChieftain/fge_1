function [error, x, y] = f_eval_fis_with_r(kkng_tau, l_t, fis_x, fis_y, x, y, error, dt, x0, y0)

persistent dex dey ux uy opt

if isempty(dex)
    dex = 0
    dey = 0
    ux = 0
    uy = 0
    opt = evalfisOptions('OutOfRangeInputValueMessage','none','NoRuleFiredMessage','none','EmptyOutputFuzzySetMessage','none');
end

for i=kkng_tau+2:l_t
    ex=x(i-1)-x0(i-1);
    dex=ex/dt;
    ux = evalfis(fis_x, [ex, dex], opt);
    x(i)=x(i-1)+ux;
    
    ey=y(i-1)-y0(i-1);
    dey=ey/dt;
    uy = evalfis(fis_y, [ey, dey], opt);
    y(i)=y(i-1)+uy;
    error=error+abs(x(i)-x0(i)+abs(y(i)-y0(i)));
end

end
