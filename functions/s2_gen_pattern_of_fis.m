function variables = s2_gen_pattern_of_fis(variables)
tic
global states_of_machine;

name_of_loading_fis = 'ellipse_fis_1.mat';
fis = load(name_of_loading_fis);

variables.pattern_of_fis = fis.elipse_fis_1;

for i=1:125
    variables.pattern_of_fis.Rules(i).Weight = 0.01*round(100*rand(1));
    variables.pattern_of_fis.Rules(i).Connection = 1;
end
s = 1;
for i=1:5
    for j=1:5
        for k=1:5
            variables.pattern_of_fis.Rules(s).Antecedent=[i j];
            variables.pattern_of_fis.Rules(s).Consequent=k;
            s=s+1;
        end
    end
end

variables.previous_state = variables.current_state;
variables.current_state = states_of_machine.s3_generate_fiss_for_x_y;
end