%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Month-by-month comparison of discharge amounts using a 
% regression tree to predict 2020-2021 discharge amounts using 
% 2018-2019 climate data
% Hypothesis tests performed for the raw data first,
% then the modeled data (commented out) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% import climate data for regression analysis
close all;
clear all;
clc
format longG

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load in the climate data for each year:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Climate_July_21 = flip(xlsread('5_yr_precip.xlsx',8, 'D5:P35'));
Climate_20_21_8mo = flip(xlsread('5_yr_precip.xlsx',3, 'D5:P246'));
Climate_20_21_raw = [Climate_20_21_8mo; Climate_July_21];
Climate_2019_raw = flip(xlsread('5_yr_precip.xlsx',5, 'D5:P369'));
Climate_2018_raw = flip(xlsread('5_yr_precip.xlsx',6, 'D5:P369'));

Month_20_21 = Climate_20_21_raw(:,1);
High_temp_20_21 = Climate_20_21_raw(:,3);
Low_temp_20_21 = Climate_20_21_raw(:,4);
Avg_temp_20_21 = Climate_20_21_raw(:,5);
Avg_RH_20_21 = Climate_20_21_raw(:,10);
Avg_windspeed_20_21 = Climate_20_21_raw(:,11);
Avg_pressure_20_21 = Climate_20_21_raw(:,13);


Climate_20_21 = [Month_20_21 ...
                        High_temp_20_21 ...
                        Low_temp_20_21 ...
                        Avg_temp_20_21 ...
                        Avg_RH_20_21 ...
                        Avg_windspeed_20_21 ...
                        Avg_pressure_20_21];


Month_19 = Climate_2019_raw(:,1);
High_temp_19 = Climate_2019_raw(:,2);
Low_temp_19 = Climate_2019_raw(:,3);
Avg_temp_19 = Climate_2019_raw(:,4);
Avg_RH_19 = Climate_2019_raw(:,10);
Avg_windspeed_19 = Climate_2019_raw(:,11);
Avg_pressure_19 = Climate_2019_raw(:,13);

Climate_2019 = [Month_19 ...
                        High_temp_19 ...
                        Low_temp_19 ...
                        Avg_temp_19 ...
                        Avg_RH_19 ...
                        Avg_windspeed_19 ...
                        Avg_pressure_19];


Month_18 = Climate_2018_raw(:,1);
High_temp_18 = Climate_2018_raw(:,2);
Low_temp_18 = Climate_2018_raw(:,3);
Avg_temp_18 = Climate_2018_raw(:,4);
Avg_RH_18 = Climate_2018_raw(:,10);
Avg_windspeed_18 = Climate_2018_raw(:,11);
Avg_pressure_18 = Climate_2018_raw(:,13);

Climate_2018 = [Month_18 ...
                        High_temp_18 ...
                        Low_temp_18 ...
                        Avg_temp_18 ...
                        Avg_RH_18 ...
                        Avg_windspeed_18 ...
                        Avg_pressure_18];




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load in ground sat for each year:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ground_Sat_18 = xlsread('Pump_Station_Flow.xlsx', 10, 'F2:F366');
Ground_Sat_19 = xlsread('Pump_Station_Flow.xlsx', 10, 'F367:F731');
Ground_Sat_20_21 = xlsread('Current_Pump_Precip.xlsx', 1, 'N2:N274');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load in precip and discharge for each year and for each station:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load in Briar Cliff November 2020 to July 2021: 
BC_Data_20_21 = xlsread('Current_Pump_Precip.xlsx',1,'A2:N274');
BC_Month_20_21 = BC_Data_20_21(:,3);
BC_Precip_20_21 = BC_Data_20_21(:,11);
BC_Discharge_20_21 = BC_Data_20_21(:,10);
% Load in Briar Cliff 2019:
BC_Data_19 = xlsread('Pump_Station_Flow.xlsx',3,'B367:J731');
BC_Month_19 = BC_Data_19(:,1);
BC_Precip_19 = BC_Data_19(:,8);
BC_Discharge_19 = BC_Data_19(:,7);
% Load in Briar Cliff 2018:
BC_Data_18 = xlsread('Pump_Station_Flow.xlsx',3,'B2:J366');
BC_Month_18 = BC_Data_18(:,1);
BC_Precip_18 = BC_Data_18(:,8);
BC_Discharge_18 = BC_Data_18(:,7);


% Load in College Gardens November 2020 to July 2021: 
CG_Data_20_21 = xlsread('Current_Pump_Precip.xlsx',2,'A2:N274');
CG_Month_20_21 = CG_Data_20_21(:,3);
CG_Precip_20_21 = CG_Data_20_21(:,11);
CG_Discharge_20_21 = CG_Data_20_21(:,10);
% Load in College Gardens 2019:
CG_Data_19 = xlsread('Pump_Station_Flow.xlsx',1,'B367:J731');
CG_Month_19 = CG_Data_19(:,1);
CG_Precip_19 = CG_Data_19(:,9);
CG_Discharge_19 = CG_Data_19(:,8);
% Load in College Gardens 2018:
CG_Data_18 = xlsread('Pump_Station_Flow.xlsx',1,'B2:J366');
CG_Month_18 = CG_Data_18(:,1);
CG_Precip_18 = CG_Data_18(:,9);
CG_Discharge_18 = CG_Data_18(:,8);


% Load in Highland November 2020 to July 2021: 
HL_Data_20_21 = xlsread('Current_Pump_Precip.xlsx',3,'A2:N274');
HL_Precip_20_21 = HL_Data_20_21(:,11);
HL_Discharge_20_21 = HL_Data_20_21(:,10);
% Load in Highland 2019:
HL_Data_19 = xlsread('Pump_Station_Flow.xlsx',5,'B367:J731');
HL_Precip_19 = HL_Data_19(:,8);
HL_Discharge_19 = HL_Data_19(:,7);
% Load in Highland 2018:
HL_Data_18 = xlsread('Pump_Station_Flow.xlsx',5,'B2:J366');
HL_Precip_18 = HL_Data_18(:,8);
HL_Discharge_18 = HL_Data_18(:,7);

% Briar Cliff discharge for 9 months, 2020-2021
month1 = find(BC_Month_20_21 == 11);
BC_Discharge_11_20 = BC_Discharge_20_21(month1);
Mean_BC_21(1) = mean(BC_Discharge_11_20);
Std_BC_21(1) = std(BC_Discharge_11_20);

month2 = find(BC_Month_20_21 == 12);
BC_Discharge_12_20 = BC_Discharge_20_21(month2);
Mean_BC_21(2) = mean(BC_Discharge_12_20);
Std_BC_21(2) = std(BC_Discharge_12_20);

month3 = find(BC_Month_20_21 == 1);
BC_Discharge_01_21 = BC_Discharge_20_21(month3);
Mean_BC_21(3) = mean(BC_Discharge_01_21);
Std_BC_21(3) = std(BC_Discharge_01_21);

month4 = find(BC_Month_20_21 == 02);
BC_Discharge_02_21 = BC_Discharge_20_21(month4);
Mean_BC_21(4) = mean(BC_Discharge_02_21);
Std_BC_21(4) = std(BC_Discharge_02_21);

month5 = find(BC_Month_20_21 == 3);
BC_Discharge_03_21 = BC_Discharge_20_21(month5);
Mean_BC_21(5) = mean(BC_Discharge_03_21);
Std_BC_21(5) = std(BC_Discharge_03_21);

month6 = find(BC_Month_20_21 == 4);
BC_Discharge_04_21 = BC_Discharge_20_21(month6);
Mean_BC_21(6) = mean(BC_Discharge_04_21);
Std_BC_21(6) = std(BC_Discharge_04_21);

month7 = find(BC_Month_20_21 == 5);
BC_Discharge_05_21 = BC_Discharge_20_21(month7);
Mean_BC_21(7) = mean(BC_Discharge_05_21);
Std_BC_21(7) = std(BC_Discharge_05_21);

month8 = find(BC_Month_20_21 == 6);
BC_Discharge_06_21 = BC_Discharge_20_21(month8);
Mean_BC_21(8) = mean(BC_Discharge_06_21);
Std_BC_21(8) = std(BC_Discharge_06_21);

month9 = find(BC_Month_20_21 == 7);
BC_Discharge_07_21 = BC_Discharge_20_21(month9);
Mean_BC_21(9) = mean(BC_Discharge_07_21);
Std_BC_21(9) = std(BC_Discharge_07_21);

% Briar Cliff discharge for 9 months, 2018-2019;
month1 = find(BC_Month_18 == 11);
BC_Discharge_11_18 = BC_Discharge_18(month1);
Mean_BC_19(1) = mean(BC_Discharge_11_18);
Std_BC_19(1) = std(BC_Discharge_11_18);

month2 = find(BC_Month_18 == 12);
BC_Discharge_12_18 = BC_Discharge_18(month2);
Mean_BC_19(2) = mean(BC_Discharge_12_18);
Std_BC_19(2) = std(BC_Discharge_12_18);

month3 = find(BC_Month_20_21 == 1);
BC_Discharge_01_19 = BC_Discharge_19(month3);
Mean_BC_19(3) = mean(BC_Discharge_01_19);
Std_BC_19(3) = std(BC_Discharge_01_19);

month4 = find(BC_Month_19 == 02);
BC_Discharge_02_19 = BC_Discharge_19(month4);
Mean_BC_19(4) = mean(BC_Discharge_02_19);
Std_BC_19(4) = std(BC_Discharge_02_19);

month5 = find(BC_Month_19 == 3);
BC_Discharge_03_19 = BC_Discharge_19(month5);
Mean_BC_19(5) = mean(BC_Discharge_03_19);
Std_BC_19(5) = std(BC_Discharge_03_19);

month6 = find(BC_Month_19 == 4);
BC_Discharge_04_19 = BC_Discharge_19(month6);
Mean_BC_19(6) = mean(BC_Discharge_04_19);
Std_BC_19(6) = std(BC_Discharge_04_19);

month7 = find(BC_Month_19 == 5);
BC_Discharge_05_19 = BC_Discharge_19(month7);
Mean_BC_19(7) = mean(BC_Discharge_05_19);
Std_BC_19(7) = std(BC_Discharge_05_19);

month8 = find(BC_Month_19 == 6);
BC_Discharge_06_19 = BC_Discharge_19(month8);
Mean_BC_19(8) = mean(BC_Discharge_06_19);
Std_BC_19(8) = std(BC_Discharge_06_19);

month9 = find(BC_Month_19 == 7);
BC_Discharge_07_19 = BC_Discharge_19(month9);
Mean_BC_19(9) = mean(BC_Discharge_07_19);
Std_BC_19(9) = std(BC_Discharge_07_19);

% College Gardens discharge for 9 months, 2020-2021
month1 = find(CG_Month_20_21 == 11);
CG_Discharge_11_20 = CG_Discharge_20_21(month1);
Mean_CG_21(1) = mean(CG_Discharge_11_20);
Std_CG_21(1) = std(CG_Discharge_11_20);

month2 = find(CG_Month_20_21 == 12);
CG_Discharge_12_20 = CG_Discharge_20_21(month2);
Mean_CG_21(2) = mean(CG_Discharge_12_20);
Std_CG_21(2) = std(CG_Discharge_12_20);

month3 = find(CG_Month_20_21 == 1);
CG_Discharge_01_21 = CG_Discharge_20_21(month3);
Mean_CG_21(3) = mean(CG_Discharge_01_21);
Std_CG_21(3) = std(CG_Discharge_01_21);

month4 = find(CG_Month_20_21 == 02);
CG_Discharge_02_21 = CG_Discharge_20_21(month4);
Mean_CG_21(4) = mean(CG_Discharge_02_21);
Std_CG_21(4) = std(CG_Discharge_02_21);

month5 = find(CG_Month_20_21 == 3);
CG_Discharge_03_21 = CG_Discharge_20_21(month5);
Mean_CG_21(5) = mean(CG_Discharge_03_21);
Std_CG_21(5) = std(CG_Discharge_03_21);

month6 = find(CG_Month_20_21 == 4);
CG_Discharge_04_21 = CG_Discharge_20_21(month6);
Mean_CG_21(6) = mean(CG_Discharge_04_21);
Std_CG_21(6) = std(CG_Discharge_04_21);

month7 = find(CG_Month_20_21 == 5);
CG_Discharge_05_21 = CG_Discharge_20_21(month7);
Mean_CG_21(7) = mean(CG_Discharge_05_21);
Std_CG_21(7) = std(CG_Discharge_05_21);

month8 = find(CG_Month_20_21 == 6);
CG_Discharge_06_21 = CG_Discharge_20_21(month8);
Mean_CG_21(8) = mean(CG_Discharge_06_21);
Std_CG_21(8) = std(CG_Discharge_06_21);

month9 = find(CG_Month_20_21 == 7);
CG_Discharge_07_21 = CG_Discharge_20_21(month9);
Mean_CG_21(9) = mean(CG_Discharge_07_21);
Std_CG_21(9) = std(CG_Discharge_07_21);

% College Gardens discharge for 9 months, 2018-2019;
month1 = find(CG_Month_18 == 11);
CG_Discharge_11_18 = CG_Discharge_18(month1);
Mean_CG_19(1) = mean(CG_Discharge_11_18);
Std_CG_19(1) = std(CG_Discharge_11_18);

month2 = find(CG_Month_18 == 12);
CG_Discharge_12_18 = CG_Discharge_18(month2);
Mean_CG_19(2) = mean(CG_Discharge_12_18);
Std_CG_19(2) = std(CG_Discharge_12_18);

month3 = find(CG_Month_20_21 == 1);
CG_Discharge_01_19 = CG_Discharge_19(month3);
Mean_CG_19(3) = mean(CG_Discharge_01_19);
Std_CG_19(3) = std(CG_Discharge_01_19);

month4 = find(CG_Month_19 == 02);
CG_Discharge_02_19 = CG_Discharge_19(month4);
Mean_CG_19(4) = mean(CG_Discharge_02_19);
Std_CG_19(4) = std(CG_Discharge_02_19);

month5 = find(CG_Month_19 == 3);
CG_Discharge_03_19 = CG_Discharge_19(month5);
Mean_CG_19(5) = mean(CG_Discharge_03_19);
Std_CG_19(5) = std(CG_Discharge_03_19);

month6 = find(CG_Month_19 == 4);
CG_Discharge_04_19 = CG_Discharge_19(month6);
Mean_CG_19(6) = mean(CG_Discharge_04_19);
Std_CG_19(6) = std(CG_Discharge_04_19);

month7 = find(CG_Month_19 == 5);
CG_Discharge_05_19 = CG_Discharge_19(month7);
Mean_CG_19(7) = mean(CG_Discharge_05_19);
Std_CG_19(7) = std(CG_Discharge_05_19);

month8 = find(CG_Month_19 == 6);
CG_Discharge_06_19 = CG_Discharge_19(month8);
Mean_CG_19(8) = mean(CG_Discharge_06_19);
Std_CG_19(8) = std(CG_Discharge_06_19);

month9 = find(CG_Month_19 == 7);
CG_Discharge_07_19 = CG_Discharge_19(month9);
Mean_CG_19(9) = mean(CG_Discharge_07_19);
Std_CG_19(9) = std(CG_Discharge_07_19);

Mean_BC_19'
Mean_BC_21'
Mean_CG_19'
Mean_CG_21'


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define predictor variables for each year:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predictor Variables November 2020 to May 2021: 
X_21(:,1) = Month_20_21(15:end);
X_21(:,2) = BC_Precip_20_21(15:end);
X_21(:,3) = Ground_Sat_20_21;
X_21(:,4) = High_temp_20_21(15:end);
X_21(:,5) = Low_temp_20_21(15:end);
X_21(:,6) = Avg_temp_20_21(15:end);
X_21(:,7) = Avg_RH_20_21(15:end);
X_21(:,8) = Avg_windspeed_20_21(15:end);
X_21(:,9) = Avg_pressure_20_21(15:end);

% Predictor Variables 2019: 
ind = find(isnan(Avg_temp_19)==0);
X_19(:,1) = Month_19(ind);
X_19(:,2) = BC_Precip_19(ind);
X_19(:,3) = Ground_Sat_19(ind);
X_19(:,4) = High_temp_19(ind);
X_19(:,5) = Low_temp_19(ind);
X_19(:,6) = Avg_temp_19(ind);
X_19(:,7) = Avg_RH_19(ind);
X_19(:,8) = Avg_windspeed_19(ind);
X_19(:,9) = Avg_pressure_19(ind);

% Predictor Variables 2018: 
X_18(:,1) = Month_18;
X_18(:,2) = BC_Precip_18;
X_18(:,3) = Ground_Sat_18;
X_18(:,4) = High_temp_18;
X_18(:,5) = Low_temp_18;
X_18(:,6) = Avg_temp_18;
X_18(:,7) = Avg_RH_18;
X_18(:,8) = Avg_windspeed_18;
X_18(:,9) = Avg_pressure_18;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define response variables for each year at each station:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Response Variable for Briar Cliff November 2020 to May 2021
Y_BC_21  = BC_Discharge_20_21(15:end);

% Response Variable for Briar Cliff 2019
Y_BC_19  = BC_Discharge_19(ind);

% Response Variable for Briar Cliff 2018
Y_BC_18  = BC_Discharge_18;


% Response Variable for College Gardens November 2020 to May 2021
Y_CG_21  = CG_Discharge_20_21(15:end);

% Response Variable for College Gardens 2019
Y_CG_19  = CG_Discharge_19(ind);

% Response Variable for College Gardens 2018
Y_CG_18  = CG_Discharge_18;


% Response Variable for Highland November 2020 to May 2021
Y_HL_21  = HL_Discharge_20_21(15:end);

% Response Variable for Highland 2019
Y_HL_19  = HL_Discharge_19(ind);

% Response Variable for Highland 2018
Y_HL_18  = HL_Discharge_18;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a global predictor and response for each Pump Station:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X_Global = [X_18; X_19; X_21];

Y_BC = [Y_BC_18; Y_BC_19; Y_BC_21];
Y_HL = [Y_HL_18; Y_HL_19; Y_CG_21];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a regression tree for each pump station:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

BC_Tree = fitrtree(X_Global, Y_BC);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a regression tree for November 2020 to May 2021
% Use 2018 and 2019 climate data as future data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X_18_19 = [X_18; X_19];

BC_20_21_Tree = fitrtree(X_21, Y_BC_21);
BC_Future_Discharge = predict(BC_20_21_Tree, X_18_19);

CG_20_21_Tree = fitrtree(X_21, Y_CG_21);
CG_Future_Discharge = predict(CG_20_21_Tree, X_18_19);

HL_20_21_Tree = fitrtree(X_21, Y_HL_21);
HL_Future_Discharge = predict(HL_20_21_Tree, X_18_19);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hypothesis Tests for 9-month periods of raw data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Briar Cliff
[h1, p1, ci, stats] = ttest2(BC_Discharge_11_18, BC_Discharge_11_20, 'Tail','right')
[h2, p2, ci, stats] = ttest2(BC_Discharge_12_18, BC_Discharge_12_20, 'Tail','right')
[h3, p3, ci, stats] = ttest2(BC_Discharge_01_19, BC_Discharge_01_21, 'Tail','right')
[h4, p4, ci, stats] = ttest2(BC_Discharge_02_19, BC_Discharge_02_21, 'Tail','right')
[h5, p5, ci, stats] = ttest2(BC_Discharge_03_19, BC_Discharge_03_21, 'Tail','right')
[h6, p6, ci, stats] = ttest2(BC_Discharge_04_19, BC_Discharge_04_21, 'Tail','right')
[h7, p7, ci, stats] = ttest2(BC_Discharge_05_19, BC_Discharge_05_21, 'Tail','right')
[h8, p8, ci, stats] = ttest2(BC_Discharge_06_19, BC_Discharge_06_21, 'Tail','right')
[h9, p9, ci, stats] = ttest2(BC_Discharge_07_19, BC_Discharge_07_21, 'Tail','right')

figure(1)
P_Values = [p1 p2 p3 p4 p5 p6 p7 p8 p9];
H_Values = [h1 h2 h3 h4 h5 h6 h7 h7 h9];
plot([11 12 1 2 3 4 5 6 7],H_Values,'ko','linewidth',5)
title('Briar Cliff','fontsize',20,'interpreter','latex')
ylim([-1 2])
grid on 
grid minor
set(gcf,'Position',[100 100 600 400])


figure(2)
errorbar([1 2 3 4 5 6 7 8 9],Mean_BC_19,Std_BC_19,'bo-','linewidth',2)
hold on
errorbar([1 2 3 4 5 6 7 8 9],Mean_BC_21,Std_BC_21,'ko-','linewidth',2)
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May', 'Jun', 'Jul'})
legend('Before Rehab','After Rehab','fontsize',18)
title('Briar Cliff','fontsize',20,'interpreter','latex')
xlim([0 10])
grid on
grid minor
set(gcf,'Position',[100 100 600 400])


% College Gardens
[h1, p1, ci, stats] = ttest2(CG_Discharge_11_18, CG_Discharge_11_20, 'Tail','right')
[h2, p2, ci, stats] = ttest2(CG_Discharge_12_18, CG_Discharge_12_20, 'Tail','right')
[h3, p3, ci, stats] = ttest2(CG_Discharge_01_19, CG_Discharge_01_21, 'Tail','right')
[h4, p4, ci, stats] = ttest2(CG_Discharge_02_19, CG_Discharge_02_21, 'Tail','right')
[h5, p5, ci, stats] = ttest2(CG_Discharge_03_19, CG_Discharge_03_21, 'Tail','right')
[h6, p6, ci, stats] = ttest2(CG_Discharge_04_19, CG_Discharge_04_21, 'Tail','right')
[h7, p7, ci, stats] = ttest2(CG_Discharge_05_19, CG_Discharge_05_21, 'Tail','right')
[h8, p8, ci, stats] = ttest2(CG_Discharge_06_19, CG_Discharge_06_21, 'Tail','right')
[h9, p9, ci, stats] = ttest2(CG_Discharge_07_19, CG_Discharge_07_21, 'Tail','right')

figure(3)
P_Values = [p1 p2 p3 p4 p5 p6 p7 p8 p9];
H_Values = [h1 h2 h3 h4 h5 h6 h7 p8 p9];
plot([11 12 1 2 3 4 5 6 7],H_Values,'ko','linewidth',5)
ylim([-1 2])
grid on 
grid minor
title('College Gardens','fontsize',20,'interpreter','latex')
set(gcf,'Position',[100 100 600 400])

figure(4)
errorbar([1 2 3 4 5 6 7 8 9],Mean_CG_19,Std_CG_19,'bo-','linewidth',2)
hold on
errorbar([1 2 3 4 5 6 7 8 9],Mean_CG_21,Std_CG_21,'ko-','linewidth',2)
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May'})
legend('Before Rehab','After Rehab','fontsize',18)
title('College Gardens','fontsize',20,'interpreter','latex')
xlim([0 10])
grid on
grid minor
set(gcf,'Position',[100 100 600 400])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hypothesis Tests for 7-month periods of modeled data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Briar Cliff projected discharge for 7 months, 2020-2021
month1 = find(X_18(:,1) == 11);
BC_Future_Discharge_11_20 = BC_Future_Discharge(month1);
Projected_Mean_BC_21(1) = mean(BC_Future_Discharge_11_20);
Projected_Std_BC_21(1) = std(BC_Future_Discharge_11_20);

month2 = find(X_18(:,1) == 12);
BC_Future_Discharge_12_20 = BC_Future_Discharge(month2);
Projected_Mean_BC_21(2) = mean(BC_Future_Discharge_12_20);
ProjectedStd_BC_21(2) = std(BC_Future_Discharge_12_20);

month3 = find(X_19(:,1) == 1);
BC_Future_Discharge_01_21 = BC_Future_Discharge(month3);
Projected_Mean_BC_21(3) = mean(BC_Future_Discharge_01_21);
Projected_Std_BC_21(3) = std(BC_Future_Discharge_01_21);

month4 = find(X_19(:,1) == 02);
BC_Future_Discharge_02_21 = BC_Future_Discharge(month4);
Projected_Mean_BC_21(4) = mean(BC_Future_Discharge_02_21);
Projected_Std_BC_21(4) = std(BC_Future_Discharge_02_21);

month5 = find(X_19(:,1) == 3);
BC_Future_Discharge_03_21 = BC_Future_Discharge(month5);
Projected_Mean_BC_21(5) = mean(BC_Future_Discharge_03_21);
Projected_Std_BC_21(5) = std(BC_Future_Discharge_03_21);

month6 = find(X_19(:,1) == 4);
BC_Future_Discharge_04_21 = BC_Future_Discharge(month6);
Projected_Mean_BC_21(6) = mean(BC_Future_Discharge_04_21);
Projected_Std_BC_21(6) = std(BC_Future_Discharge_04_21);

month7 = find(X_19(:,1) == 5);
BC_Future_Discharge_05_21 = BC_Future_Discharge(month7);
Projected_Mean_BC_21(7) = mean(BC_Future_Discharge_05_21);
Projected_Std_BC_21(7) = std(BC_Future_Discharge_05_21);

month8 = find(X_19(:,1) == 6);
BC_Future_Discharge_06_21 = BC_Future_Discharge(month8);
Projected_Mean_BC_21(8) = mean(BC_Future_Discharge_06_21);
Projected_Std_BC_21(8) = std(BC_Future_Discharge_06_21);

month9 = find(X_19(:,1) == 7);
BC_Future_Discharge_07_21 = BC_Future_Discharge(month9);
Projected_Mean_BC_21(9) = mean(BC_Future_Discharge_07_21);
Projected_Std_BC_21(9) = std(BC_Future_Discharge_07_21);


% College Gardens projected discharge for 7 months, 2020-2021
month1 = find(X_18(:,1) == 11);
CG_Future_Discharge_11_20 = CG_Future_Discharge(month1);
Projected_Mean_CG_21(1) = mean(CG_Future_Discharge_11_20);
Projected_Std_CG_21(1) = std(CG_Future_Discharge_11_20);

month2 = find(X_18(:,1) == 12);
CG_Future_Discharge_12_20 = CG_Future_Discharge(month2);
Projected_Mean_CG_21(2) = mean(CG_Future_Discharge_12_20);
Projected_Std_CG_21(2) = std(CG_Future_Discharge_12_20);

month3 = find(X_19(:,1) == 1);
CG_Future_Discharge_01_21 = CG_Future_Discharge(month3);
Projected_Mean_CG_21(3) = mean(CG_Future_Discharge_01_21);
Projected_Std_CG_21(3) = std(CG_Future_Discharge_01_21);

month4 = find(X_19(:,1) == 02);
CG_Future_Discharge_02_21 = CG_Future_Discharge(month4);
Projected_Mean_CG_21(4) = mean(CG_Future_Discharge_02_21);
Projected_Std_CG_21(4) = std(CG_Future_Discharge_02_21);

month5 = find(X_19(:,1) == 3);
CG_Future_Discharge_03_21 = CG_Future_Discharge(month5);
Projected_Mean_CG_21(5) = mean(CG_Future_Discharge_03_21);
Projected_Std_CG_21(5) = std(CG_Future_Discharge_03_21);

month6 = find(X_19(:,1) == 4);
CG_Future_Discharge_04_21 = CG_Future_Discharge(month6);
Projected_Mean_CG_21(6) = mean(CG_Future_Discharge_04_21);
Projected_Std_CG_21(6) = std(CG_Future_Discharge_04_21);

month7 = find(X_19(:,1) == 5);
CG_Future_Discharge_05_21 = CG_Future_Discharge(month7);
Projected_Mean_CG_21(7) = mean(CG_Future_Discharge_05_21);
Projected_Std_CG_21(7) = std(CG_Future_Discharge_05_21);

month8 = find(X_19(:,1) == 6);
CG_Future_Discharge_06_21 = CG_Future_Discharge(month8);
Projected_Mean_CG_21(8) = mean(CG_Future_Discharge_06_21);
Projected_Std_CG_21(8) = std(CG_Future_Discharge_06_21);

month9 = find(X_19(:,1) == 7);
CG_Future_Discharge_07_21 = CG_Future_Discharge(month9);
Projected_Mean_CG_21(9) = mean(CG_Future_Discharge_07_21);
Projected_Std_CG_21(9) = std(CG_Future_Discharge_07_21);


% Briar Cliff
% [h1, p1, ci, stats] = ttest2(BC_Discharge_11_18, BC_Future_Discharge_11_20, 'Tail','right')
% [h2, p2, ci, stats] = ttest2(BC_Discharge_12_18, BC_Future_Discharge_12_20, 'Tail','right')
% [h3, p3, ci, stats] = ttest2(BC_Discharge_01_19, BC_Future_Discharge_01_21, 'Tail','right')
% [h4, p4, ci, stats] = ttest2(BC_Discharge_02_19, BC_Future_Discharge_02_21, 'Tail','right')
% [h5, p5, ci, stats] = ttest2(BC_Discharge_03_19, BC_Future_Discharge_03_21, 'Tail','right')
% [h6, p6, ci, stats] = ttest2(BC_Discharge_04_19, BC_Future_Discharge_04_21, 'Tail','right')
% [h7, p7, ci, stats] = ttest2(BC_Discharge_05_19, BC_Future_Discharge_05_21, 'Tail','right')
% [h8, p8, ci, stats] = ttest2(BC_Discharge_06_19, BC_Future_Discharge_06_21, 'Tail','right')
% [h9, p9, ci, stats] = ttest2(BC_Discharge_07_19, BC_Future_Discharge_07_21, 'Tail','right')

% figure(5)
% P_Values = [p1 p2 p3 p4 p5 p6 p7 p8 p9];
% H_Values = [h1 h2 h3 h4 h5 h6 h7 h8 h9];
% plot([11 12 1 2 3 4 5 6 7],H_Values,'ko','linewidth',5)
% title('Briar Cliff: Projected Discharge','fontsize',20)
% grid on 
% grid minor
% 
% figure(6)
% errorbar([1 2 3 4 5 6 7 8 9],Mean_BC_19,Std_BC_19,'bo-','linewidth',2)
% hold on
% errorbar([1 2 3 4 5 6 7 8 9],Projected_Mean_BC_21,Projected_Std_BC_21,'ko-','linewidth',2)
% xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May', 'Jun', 'Jul'})
% legend('Before Rehab','After Rehab','fontsize',20)
% title('Briar Cliff: Projected Discharge','fontsize',20)
% xlim([0 10])
% grid on
% grid minor
% 

% [h1, p1, ci, stats] = ttest2(CG_Discharge_11_18, CG_Future_Discharge_11_20, 'Tail','right')
% [h2, p2, ci, stats] = ttest2(CG_Discharge_12_18, CG_Future_Discharge_12_20, 'Tail','right')
% [h3, p3, ci, stats] = ttest2(CG_Discharge_01_19, CG_Future_Discharge_01_21, 'Tail','right')
% [h4, p4, ci, stats] = ttest2(CG_Discharge_02_19, CG_Future_Discharge_02_21, 'Tail','right')
% [h5, p5, ci, stats] = ttest2(CG_Discharge_03_19, CG_Future_Discharge_03_21, 'Tail','right')
% [h6, p6, ci, stats] = ttest2(CG_Discharge_04_19, CG_Future_Discharge_04_21, 'Tail','right')
% [h7, p7, ci, stats] = ttest2(CG_Discharge_05_19, CG_Future_Discharge_05_21, 'Tail','right')
% [h8, p8, ci, stats] = ttest2(CG_Discharge_06_19, CG_Future_Discharge_06_21, 'Tail','right')
% [h9, p9, ci, stats] = ttest2(CG_Discharge_07_19, CG_Future_Discharge_07_21, 'Tail','right')

% figure(7)
% P_Values = [p1 p2 p3 p4 p5 p6 p7 p8 p9];
% H_Values = [h1 h2 h3 h4 h5 h6 h7 h8 h9];
% plot([11 12 1 2 3 4 5 6 7],H_Values,'ko','linewidth',5)
% grid on 
% grid minor
% title('College Garden: Projected Discharge','fontsize',20)
% 
% figure(8)
% errorbar([1 2 3 4 5 6 7 8 9],Mean_CG_19,Std_CG_19,'bo-','linewidth',2)
% hold on
% errorbar([1 2 3 4 5 6 7 8 9],Projected_Mean_CG_21,Projected_Std_CG_21,'ko-','linewidth',2)
% xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul'})
% legend('Before Rehab','After Rehab','fontsize',20)
% title('College Garden: Projected Discharge','fontsize',20)
% xlim([0 10])
% grid on
% grid minor

