current_data_of_x = training_data_for_anfis_of_x0(1, :);
target_data_of_x = training_data_for_anfis_of_x0(2, :);

current_data_of_y = training_data_for_anfis_of_y0(1, :);
target_data_of_y = training_data_for_anfis_of_y0(2, :);

genopt_x = genfisOptions('GridPartition');
genopt_x.NumMembershipFunctions = 125;
genopt_x.InputMembershipFunctionType = 'gaussmf';
inFIS_x = genfis(current_data_of_x(:),target_data_of_x(:),genopt_x);

opt_x = anfisOptions('InitialFIS',inFIS_x);
opt_x.DisplayANFISInformation = 0;
opt_x.DisplayErrorValues = 0;
opt_x.DisplayStepSize = 0;
opt_x.DisplayFinalResults = 0;

outFIS_x = anfis([current_data_of_x(:) target_data_of_x(:)],opt_x);

genopt_y = genfisOptions('GridPartition');
genopt_y.NumMembershipFunctions = 125;
genopt_y.InputMembershipFunctionType = 'gaussmf';
inFIS_y = genfis(current_data_of_y(:),target_data_of_y(:),genopt_y);

opt_y = anfisOptions('InitialFIS',inFIS_y);
opt_y.DisplayANFISInformation = 0;
opt_y.DisplayErrorValues = 0;
opt_y.DisplayStepSize = 0;
opt_y.DisplayFinalResults = 0;

outFIS_y = anfis([current_data_of_x(:) target_data_of_x(:)],opt_y);

plot(current_data_of_x,current_data_of_y,evalfis(outFIS_x,current_data_of_x),evalfis(outFIS_y,current_data_of_y))
legend('Target Data','ANFIS Output')