% Comparing monthly discharge and I&I amounts 
% Pre-rehab (2018 to 2019) vs post-rehab (2020 to 2021)
% using hypothesis testing and visualizations

clear all;
close all;
clc

% Importing table of monthly discharge, I&I and I&I % from Excel
Monthly_I_I = xlsread('5_yr_precip.xlsx',7,'B2:AG35');

Year = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 11; 12;];
%X = [1; 2; 3; 4; 5; 6; 7; 8; 9];
Year_21 = [1; 2; 3; 4; 5; 6; 7];

% 2018 Monthly I & I, creating 12x4 matrices
% Briar Cliff 2018
BC_18 = Monthly_I_I(1:12,2:5);

% College Gardens 2018
CG_18 = Monthly_I_I(1:12,10:13);

% Highland 2018
HL_18 = Monthly_I_I(1:12,18:21);

% No data for Hilltop 2018


% 2019 I & I, creating 12x4 matrices
% Briar CLiff
BC_19 = Monthly_I_I(13:24,2:5);

% College Gardens
CG_19 = Monthly_I_I(13:24,10:13);

% Highland
HL_19 = Monthly_I_I(13:24,18:21);

% Hilltop
HT_19 = Monthly_I_I(13:24,26:29);


% Novermber 2020 to May 2021 I & I
% Briar Cliff
BC_20_21 = Monthly_I_I(26:34,2:5);  % Includes Nov & Dec 2020, 9x4
BC_21 = Monthly_I_I(28:34,2:5);     % Only 2021, 7x4

% College Gardens
CG_20_21 = Monthly_I_I(26:34,10:13);
CG_21 = Monthly_I_I(28:34,10:13);

% Highland
HL_20_21 = Monthly_I_I(26:34,18:21);
HL_21 = Monthly_I_I(28:34,18:21);

% Hilltop
HT_20_21 = Monthly_I_I(26:34,26:29);
HT_21 = Monthly_I_I(28:34,26:29);

% Create 24x1 column vector
BC_18_19_Discharge = [BC_18(:,1); BC_19(:,1)];
CG_18_19_Discharge = [CG_18(:,1); CG_19(:,1)];
HL_18_19_Discharge = [HL_18(:,1); HL_19(:,1)];

% Create a 9x1 column vector
BC_20_21_Discharge = BC_20_21(:,1);
CG_20_21_Discharge = CG_20_21(:,1);
HL_20_21_Discharge = HL_20_21(:,1);

% BC_18_19_Mean_Discharge = mean(BC_18_19_Discharge);
% BC_20_21_Mean_Discharge = mean(BC_20_21_Discharge);
% 
% CG_18_19_Mean_Discharge = mean(CG_18_19_Discharge);
% CG_20_21_Mean_Discharge = mean(CG_20_21_Discharge);
% 
% HL_18_19_Mean_Discharge = mean(HL_18_19_Discharge);
% HL_20_21_Mean_Discharge = mean(HL_20_21_Discharge);

BC_18_19_II_Avg = [BC_18(:,3); BC_19(:,3)];
CG_18_19_II_Avg = [CG_18(:,3); CG_19(:,3)];
HL_18_19_II_Avg = [HL_18(:,3); HL_19(:,3)];

BC_20_21_II_Avg = BC_20_21(:,3);
CG_20_21_II_Avg = CG_20_21(:,3);
HL_20_21_II_Avg = HL_20_21(:,3);

% Daily discharge data to compare with hypothesis tests
% done with monthly averages
% Load in Briar Cliff November 2020 to July 2021: 
BC_Data_20_21 = xlsread('Current_Pump_Precip.xlsx',1,'A2:N274');
BC_Discharge_20_21_byDay = BC_Data_20_21(:,10);
% Load in Briar Cliff 2019:
BC_Data_18_19 = xlsread('Pump_Station_Flow.xlsx',3,'B2:J731');
BC_Discharge_18_19_byDay = BC_Data_18_19(:,7);


% Load in College Gardens November 2020 to July 2021: 
CG_Data_20_21 = xlsread('Current_Pump_Precip.xlsx',2,'A2:N274');
CG_Discharge_20_21_byDay = CG_Data_20_21(:,10);
% Load in College Gardens 2019:
CG_Data_18_19 = xlsread('Pump_Station_Flow.xlsx',1,'B2:J731');
CG_Discharge_18_19_byDay = CG_Data_18_19(:,8);

% Hypothesis tests for pre-rehab vs post-rehab, using daily discharge
[h1, p1, ci, stats] = ttest2(BC_Discharge_18_19_byDay, BC_Discharge_20_21_byDay, 'Tail','right')
[h2, p2, ci, stats] = ttest2(CG_Discharge_18_19_byDay, CG_Discharge_20_21_byDay, 'Tail','right')

% Hypothesis tests for pre-rehab vs post-rehab, using monthly discharge
[h3, p3, ci, stats] = ttest2(BC_18_19_Discharge, BC_20_21_Discharge, 'Tail','right')
[h4, p4, ci, stats] = ttest2(CG_18_19_Discharge, CG_20_21_Discharge, 'Tail','right')
%[h, p, ci, stats] = ttest2(HL_18_19_Discharge, HL_20_21_Discharge, 'Tail','right')

% Hypothesis tests for pre-rehab vs post-rehab, using monthly average I&I
%[h, p, ci, stats] = ttest2(BC_18_19_II_Avg, BC_20_21_II_Avg, 'Tail','right')
%[h, p, ci, stats] = ttest2(CG_18_19_II_Avg, CG_20_21_II_Avg, 'Tail','right')
%[h, p, ci, stats] = ttest2(HL_18_19_II_Avg, HL_20_21_II_Avg, 'Tail','right')



% Visualizations
% Briar Cliff
figure(1)
%plot(Year, BC_18(:,[2 4]), 'k-', 'linewidth',2)

plot(Year, BC_18(:,3), 'linewidth',2)
hold on
%plot(Year, BC_19(:,[2 4]), 'k-', 'linewidth',2)
plot(Year, BC_19(:,3), 'linewidth',2)
%plot(Year_21, BC_21(:,[2 4]), 'k-', 'linewidth',3)
plot(Year_21, BC_21(:,3), 'linewidth',3)
title('Briar Cliff I & I: 2018, 2019, and 2021', 'fontsize', 18)
grid on
grid minor

% College Gardens
figure(2)
%plot(Year, CG_18(:,[2 4]), 'k-', 'linewidth',2)
hold on
plot(Year, CG_18(:,3), 'linewidth',2)
%plot(Year, CG_19(:,[2 4]), 'k-', 'linewidth',2)
plot(Year, CG_19(:,3), 'linewidth',2)
%plot(Year_21, CG_21(:,[2 4]), 'k-', 'linewidth',3)
plot(Year_21, CG_21(:,3), 'linewidth',3)
title('College Gardens I & I: 2018, 2019, and 2021', 'fontsize', 18)
grid on
grid minor

% Highland
figure(3)
plot(Year, HL_18(:,[2 4]), 'k-', 'linewidth',2)
hold on
plot(Year, HL_18(:,3), 'bo', 'linewidth',2)
plot(Year, HL_19(:,[2 4]), 'k-', 'linewidth',2)
plot(Year, HL_19(:,3), 'ro', 'linewidth',2)
plot(Year_21, HL_21(:,[2 4]), 'k-', 'linewidth',3)
plot(Year_21, HL_21(:,3), 'go', 'linewidth',3)
title('Highland I & I: 2018, 2019, and 2021', 'fontsize', 18)
grid on
grid minor

BC_II_18_19 = [BC_18(:,3); BC_19(:,3)];
BC_avg_II_18_19 = mean(BC_II_18_19)
BC_avg_II_20_21 = mean(BC_20_21(:,3))

CG_II_18_19 = [CG_18(:,3); CG_19(:,3)];
CG_avg_II_18_19 = mean(CG_II_18_19)
CG_avg_II_20_21 = mean(CG_20_21(:,3))

Avg_II_18_19(1) = mean(BC_II_18_19);
Avg_II_18_19(2) = mean(CG_II_18_19);
Std_II_18_19(1) = std(BC_II_18_19);
Std_II_18_19(2) = std(CG_II_18_19);

Avg_II_20_21(1) = mean(BC_20_21_II_Avg);
Avg_II_20_21(2) = mean(BC_20_21_II_Avg);
Std_II_20_21(1) = std(BC_20_21_II_Avg);
Std_II_20_21(2) = std(BC_20_21_II_Avg);


box1 = [BC_II_18_19 CG_II_18_19];
% Briar Cliff boxchart
figure(4)
errorbar([1 2],Avg_II_18_19,Std_II_18_19,'ro-','linewidth',2)
hold on
errorbar([1 2],Avg_II_20_21,Std_II_20_21,'bo-','linewidth',2)
xlim([0 3])
