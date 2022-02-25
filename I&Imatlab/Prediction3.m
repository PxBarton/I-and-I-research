%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prediction3.m
% Imports climate data and creates vectors for predictor variables 
% Uses regression trees to predict future discharge amounts
% Performs hypothesis tests to evaluate rehab success
% Pruning and K-fold cross validation employed to improve model
% Random forests and support vector machines results compared with 
% regression tree models, no notable improvement
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
Climate_20_21 = [Climate_20_21_8mo; Climate_July_21];
Climate_2019 = flip(xlsread('5_yr_precip.xlsx',5, 'D5:P369'));
Climate_2018 = flip(xlsread('5_yr_precip.xlsx',6, 'D5:P369'));

Month_20_21 = Climate_20_21(:,1);
High_temp_20_21 = Climate_20_21(:,3);
Low_temp_20_21 = Climate_20_21(:,4);
Avg_temp_20_21 = Climate_20_21(:,5);
Avg_RH_20_21 = Climate_20_21(:,10);
Avg_windspeed_20_21 = Climate_20_21(:,11);
Avg_pressure_20_21 = Climate_20_21(:,13);


Month_19 = Climate_2019(:,1);
High_temp_19 = Climate_2019(:,2);
Low_temp_19 = Climate_2019(:,3);
Avg_temp_19 = Climate_2019(:,4);
Avg_RH_19 = Climate_2019(:,10);
Avg_windspeed_19 = Climate_2019(:,11);
Avg_pressure_19 = Climate_2019(:,13);


Month_18 = Climate_2018(:,1);
High_temp_18 = Climate_2018(:,2);
Low_temp_18 = Climate_2018(:,3);
Avg_temp_18 = Climate_2018(:,4);
Avg_RH_18 = Climate_2018(:,10);
Avg_windspeed_18 = Climate_2018(:,11);
Avg_pressure_18 = Climate_2018(:,13);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load in ground sat for each year:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ground_Sat_18 = xlsread('Pump_Station_Flow.xlsx', 10, 'F2:F366');
Ground_Sat_19 = xlsread('Pump_Station_Flow.xlsx', 10, 'F367:F731');
Ground_Sat_20_21 = xlsread('Current_Pump_Precip.xlsx', 1, 'N2:N274');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load in precip and discharge for each year and for each station:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load in Briar Cliff November 2020 to May 2021: 
BC_Data_20_21 = xlsread('Current_Pump_Precip.xlsx',1,'A2:N274');
BC_Precip_20_21 = BC_Data_20_21(:,11);
BC_Discharge_20_21 = BC_Data_20_21(:,10);
% Load in Briar Cliff 2019:
BC_Data_19 = xlsread('Pump_Station_Flow.xlsx',3,'B367:J731');
BC_Precip_19 = BC_Data_19(:,8);
BC_Discharge_19 = BC_Data_19(:,7);
% Load in Briar Cliff 2018:
BC_Data_18 = xlsread('Pump_Station_Flow.xlsx',3,'B2:J366');
BC_Precip_18 = BC_Data_18(:,8);
BC_Discharge_18 = BC_Data_18(:,7);


% Load in College Gardens November 2020 to May 2021: 
CG_Data_20_21 = xlsread('Current_Pump_Precip.xlsx',2,'A2:N274');
CG_Precip_20_21 = CG_Data_20_21(:,11);
CG_Discharge_20_21 = CG_Data_20_21(:,10);
% Load in College Gardens 2019:
CG_Data_19 = xlsread('Pump_Station_Flow.xlsx',1,'B367:J731');
CG_Precip_19 = CG_Data_19(:,9);
CG_Discharge_19 = CG_Data_19(:,8);
% Load in College Gardens 2018:
CG_Data_18 = xlsread('Pump_Station_Flow.xlsx',1,'B2:J366');
CG_Precip_18 = CG_Data_18(:,9);
CG_Discharge_18 = CG_Data_18(:,8);


% Load in Highland November 2020 to May 2021: 
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

% Briar Cliff: create regression tree, check resubstution error 
% and cross-validate, k-fold loss error
BC_20_21_Tree = fitrtree(X_21, Y_BC_21);
%BC_20_21_Tree = fitrtree(X_21, Y_BC_21, 'MaxNumSplits', 10, 'OptimizeHyperparameters','auto');
Resub_BC = sqrt(resubLoss(BC_20_21_Tree))
Cross_BC_Tree = crossval(BC_20_21_Tree);
BCLoss = sqrt(kfoldLoss(Cross_BC_Tree))

% repeat with pruned tree
BC_PrTree = prune(BC_20_21_Tree);
Resub_BC_Pr = sqrt(resubLoss(BC_PrTree))
Cross_BC_PrTree = crossval(BC_PrTree);
BCLoss_Pr = sqrt(kfoldLoss(Cross_BC_PrTree))

BC_Future_Discharge = predict(BC_20_21_Tree, X_18_19);

% College Gardens: create regression tree, check resubstution error 
% and cross-validate, k-fold loss error
CG_20_21_Tree = fitrtree(X_21, Y_CG_21);
%CG_20_21_Tree = fitrtree(X_21, Y_CG_21, 'MaxNumSplits', 10, 'OptimizeHyperparameters','auto');
CG_Future_Discharge = predict(CG_20_21_Tree, X_18_19);
Resub_CG = sqrt(resubLoss(CG_20_21_Tree))
Cross_CG_Tree = crossval(CG_20_21_Tree);
CGLoss = sqrt(kfoldLoss(Cross_CG_Tree))

% repeat with pruned tree
CG_PrTree = prune(CG_20_21_Tree);
Resub_CG_Pr = sqrt(resubLoss(CG_PrTree))
Cross_CG_PrTree = crossval(CG_PrTree);
CGLoss_Pr = sqrt(kfoldLoss(Cross_CG_PrTree))

HL_20_21_Tree = fitrtree(X_21, Y_HL_21);
HL_Future_Discharge = predict(HL_20_21_Tree, X_18_19);

% t-tests for comparing the average discharges, pre and post rehab,
% for both Briar Cliff & College Gardens

BC_Discharge_18_19 = [BC_Discharge_18; BC_Discharge_19];
CG_Discharge_18_19 = [CG_Discharge_18; CG_Discharge_19];




[h1, p1, ci, stats] = ttest2(BC_Discharge_18_19, BC_Discharge_20_21, 'Tail','right')
[h2, p2, ci, stats] = ttest2(CG_Discharge_18_19, CG_Discharge_20_21, 'Tail','right')

BC_mean_18_19 = mean(BC_Discharge_18_19)
BC_mean_20_21 = mean(BC_Discharge_20_21)
CG_mean_18_19 = mean(CG_Discharge_18_19)
CG_mean_20_21 = mean(CG_Discharge_20_21)

[h3, p3, ci, stats] = ttest2(BC_Discharge_18_19, BC_Future_Discharge, 'Tail','right')
[h4, p4, ci, stats] = ttest2(CG_Discharge_18_19, CG_Future_Discharge, 'Tail','right')

mean_BC_predict = mean(BC_Future_Discharge)
mean_CG_predict = mean(CG_Future_Discharge)

% random forest version
BC_20_21_Forest = fitrensemble(X_21, Y_BC_21);
% BC_20_21_Forest = fitrensemble(X_21(:,2:end), Y_BC_21);
BC_Future_Discharge2 = predict(BC_20_21_Forest, X_18_19);
% BC_Future_Discharge2 = predict(BC_20_21_Forest, X_18_19(:,2:end));

CG_20_21_Forest = fitrensemble(X_21, Y_CG_21);
% CG_20_21_Forest = fitrensemble(X_21(:,2:end), Y_CG_21);
CG_Future_Discharge2 = predict(CG_20_21_Forest, X_18_19);
% CG_Future_Discharge2 = predict(CG_20_21_Forest, X_18_19(:,2:end));

mean_BC_predict2 = mean(BC_Future_Discharge2);
mean_CG_predict2 = mean(CG_Future_Discharge2);

Resub_BC_Forest = sqrt(resubLoss(BC_20_21_Forest));
Resub_CG_Forest = sqrt(resubLoss(CG_20_21_Forest));

Cross_CG_Forest = crossval(CG_20_21_Forest);
Loss_CG_Forest = sqrt(kfoldLoss(Cross_CG_Forest));
% With both the standard regression tree and the random forest, the month
% appears to be an extremely strong predictor, reducing the predicted mean
% for College Gardens by approx 70% in the random forest case

% Support Vector Machine (SVM) model version
BC_20_21_SVM = fitrsvm(X_21, Y_BC_21);
BC_Future_Discharge3 = predict(BC_20_21_SVM, X_18_19);

CG_20_21_SVM = fitrsvm(X_21, Y_CG_21);
CG_Future_Discharge3 = predict(CG_20_21_SVM, X_18_19);

mean_BC_predict3 = mean(BC_Future_Discharge3);
mean_CG_predict3 = mean(CG_Future_Discharge3);

BC_SVM_Loss = sqrt(resubLoss(BC_20_21_SVM));
CG_SVM_Loss = sqrt(resubLoss(CG_20_21_SVM));

view(BC_20_21_Tree,'Mode', 'Graph')