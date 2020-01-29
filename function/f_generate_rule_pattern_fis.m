function temp_fis=f_generate_rule_pattern_fis(temp_fis)
for i=1:125
    temp_fis.Rules(i).Weight = 0.01*round(100*rand(1));
    temp_fis.Rules(i).Connection = 1;
end
s = 1;
for i=1:5
    for j=1:5
        for k=1:5
            temp_fis.Rules(s).Antecedent=[i j];
            temp_fis.Rules(s).Consequent=k;
            s=s+1;
        end
    end
end
end
