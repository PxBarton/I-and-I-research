% Calculating Deviations for each month for pre and post Discharge: 
close all, clear all, clc

% Import Data from 2020
BC_Post = readmatrix('Post_PS_Stations_by_Sheet.xlsx',...
                     'Sheet','BriarCliff','Range','B2:K427');
BC_Pre  = readmatrix('Pre_PS_Stations_by_Sheet.xlsx',...
                     'Sheet','BriarCliff','Range','B2:K762');

BC_TD_Post = cell(1,12);
BC_TD_Pre = cell(1,12);

for i = 1:12
    ind = find(BC_Post(:,3) == i);
    BC_TD_Post{i} = BC_Post(ind,10);  
    ind = find(BC_Pre(:,3) == i);
    BC_TD_Pre{i} = BC_Pre(ind,10);  

    BC_Mean_Post(i) = mean(BC_TD_Post{i});
    BC_STD_Post(i)  = std(BC_TD_Post{i});
    BC_Mean_Pre(i) = mean(BC_TD_Pre{i});
    BC_STD_Pre(i)  = std(BC_TD_Pre{i});

end

figure(1)
errorbar(1:12,BC_Mean_Post,BC_STD_Post,'bo-','linewidth',2)
hold on
errorbar(1:12,BC_Mean_Pre,BC_STD_Pre,'ko-','linewidth',2)
xticks(0:13)
xticklabels({'','Jan','Feb','Mar','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec',''})
legend('Before Rehab','After Rehab','fontsize',18)
title('College Gardens','fontsize',20,'interpreter','latex')
xlim([0 13])


% Error bar plots: 
for j = 1:12

    [h(j),p(j),ci(:,j),stats] = ttest2(BC_TD_Pre{j}, BC_TD_Post{j}, 'Tail','right');

end
    grid minor


%%

% College Gardens
for k = 1:12

[h1, p1, ci, stats] = ttest2(BC_TD_Pre{k}, BC_TD_Post{k}, 'Tail','right')


end

[h1, p1, ci, stats] = ttest2(CG_Discharge_11_18, CG_Discharge_11_20, 'Tail','right')



[h2, p2, ci, stats] = ttest2(CG_Discharge_12_18, CG_Discharge_12_20, 'Tail','right')
[h3, p3, ci, stats] = ttest2(CG_Discharge_01_19, CG_Discharge_01_21, 'Tail','right')
[h4, p4, ci, stats] = ttest2(CG_Discharge_02_19, CG_Discharge_02_21, 'Tail','right')
[h5, p5, ci, stats] = ttest2(CG_Discharge_03_19, CG_Discharge_03_21, 'Tail','right')
[h6, p6, ci, stats] = ttest2(CG_Discharge_04_19, CG_Discharge_04_21, 'Tail','right')
[h7, p7, ci, stats] = ttest2(CG_Discharge_05_19, CG_Discharge_05_21, 'Tail','right')
[h8, p8, ci, stats] = ttest2(CG_Discharge_06_19, CG_Discharge_06_21, 'Tail','right')
[h9, p9, ci, stats] = ttest2(CG_Discharge_07_19, CG_Discharge_07_21, 'Tail','right')