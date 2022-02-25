% Partitioning the precipitation and ground sat data
% into rain events and non-rain events
% Conduct hypothesis testing to determine whether rehab
% for College Gardens and Briar Cliff was effective during rain events

clear all;
close all;
clc;


% Briar Cliff 2018-2019
% Load Data into matrix form.
BC_Data_18_19 = xlsread('Pump_Station_Flow.xlsx',3,'B2:J731');
BC_Discharge_18_19 = BC_Data_18_19(:,7);

% College Gardens 2018-2019
% Load Data into matrix form.
CG_Data_18_19 = xlsread('Pump_Station_Flow.xlsx',1,'B2:J731');
CG_Discharge_18_19 = CG_Data_18_19(:,8);

% Ground Saturation for 2018-2019
Ground_Sat_Data_18_19 = xlsread('Pump_Station_Flow.xlsx',10,'F2:F731');

% Precipitation for 2018-2019
Precip_Data_18_19 = BC_Data_18_19(:,8);

% Briar Cliff 2020-2021
BC_Data_20_21 = xlsread('Current_Pump_Precip.xlsx',1,'A2:N274');
BC_Discharge_20_21 = BC_Data_20_21(:,10);

% College Gardens 2020-2021
CG_Data_20_21 = xlsread('Current_Pump_Precip.xlsx',2,'A2:N274');
CG_Discharge_20_21 = CG_Data_20_21(:,10);

% Ground Saturation for 2020-2021
Ground_Sat_Data_20_21 = BC_Data_20_21(:,14);

% Precipitation for 2020-2021
Precip_Data_20_21 = BC_Data_20_21(:,11);



% define rain events for 2018-2019 and locate corresponding indices
ind1 = find(Precip_Data_18_19 > 1);
ind2 = find(Ground_Sat_Data_18_19 > 3);
ind_18_19 = union(ind1, ind2);

% define the complement of rain events (no rain) and locate indices
not_ind1 = find(Precip_Data_18_19 <= 1);
not_ind2 = find(Ground_Sat_Data_18_19 <= 3);
not_ind_18_19 = intersect(not_ind1,not_ind2);

BC_Discharge_18_19_Rain = BC_Discharge_18_19(ind_18_19);
%BC_Discharge_No_Rain = setdiff(BC_Discharge_18_19, BC_Discharge_18_19_Rain)

BC_Discharge_18_19_NoRain = BC_Discharge_18_19(not_ind_18_19);

CG_Discharge_18_19_Rain = CG_Discharge_18_19(ind_18_19);
%CG_Discharge_No_Rain = setdiff(CG_Discharge_18_19, CG_Discharge_18_19_Rain)

CG_Discharge_18_19_NoRain = CG_Discharge_18_19(not_ind_18_19);

% define rain events for 2020-2021 and locate corresponding indices
ind3 = find(Precip_Data_20_21 > 1);
ind4 = find(Ground_Sat_Data_20_21 > 3);
ind_20_21 = union(ind3, ind4);

% define the complement of rain events (no rain) and locate indices
not_ind3 = find(Precip_Data_20_21 <= 1);
not_ind4 = find(Ground_Sat_Data_20_21 <= 3);
not_ind_20_21 = intersect(not_ind3,not_ind4);

BC_Discharge_20_21_Rain = BC_Discharge_20_21(ind_20_21);
%BC_Discharge_No_Rain = setdiff(BC_Discharge_18_19, BC_Discharge_18_19_Rain)

BC_Discharge_20_21_NoRain = BC_Discharge_20_21(not_ind_20_21);

CG_Discharge_20_21_Rain = CG_Discharge_20_21(ind_20_21);
%CG_Discharge_No_Rain = setdiff(CG_Discharge_18_19, CG_Discharge_18_19_Rain)

CG_Discharge_20_21_NoRain = CG_Discharge_20_21(not_ind_20_21);

% find correlation coefficiants and R^2 for 2018-2019 rain events vs
% rain events vs discharge
% Briar Cliff
BC_Coeff_18_19 = polyfit(Ground_Sat_Data_18_19(ind2),BC_Discharge_18_19(ind2),1);
BC_18_19_Best_Fit = polyval(BC_Coeff_18_19, Ground_Sat_Data_18_19(ind2));
BC_18_19_Rsq = corrcoef(BC_Discharge_18_19(ind2), BC_18_19_Best_Fit).^2
% College Gardens
CG_Coeff_18_19 = polyfit(Ground_Sat_Data_18_19(ind2),CG_Discharge_18_19(ind2),1);
CG_18_19_Best_Fit = polyval(CG_Coeff_18_19, Ground_Sat_Data_18_19(ind2));
CG_18_19_Rsq = corrcoef(CG_Discharge_18_19(ind2), CG_18_19_Best_Fit).^2


% find correlation coefficiants and R^2 for 2020-2021 
% rain events vs discharge
% Briar Cliff
BC_Coeff_20_21 = polyfit(Ground_Sat_Data_20_21(ind4),BC_Discharge_20_21(ind4),1);
BC_20_21_Best_Fit = polyval(BC_Coeff_20_21, Ground_Sat_Data_20_21(ind4));
BC_20_21_Rsq = corrcoef(BC_Discharge_20_21(ind4), BC_20_21_Best_Fit).^2
% College Gardens
CG_Coeff_20_21 = polyfit(Ground_Sat_Data_20_21(ind4),CG_Discharge_20_21(ind4),1);
CG_20_21_Best_Fit = polyval(CG_Coeff_20_21, Ground_Sat_Data_20_21(ind4));
CG_20_21_Rsq = corrcoef(CG_Discharge_20_21(ind4), CG_20_21_Best_Fit).^2


% hypothesis test comparing the discharge of 2018-2019 (raw data)
% with the corresponding discharge data for 2020-2021
[h0, p, ci, stats] = ttest2(BC_Discharge_18_19, BC_Discharge_20_21, 'Tail','right')
[h0, p, ci, stats] = ttest2(CG_Discharge_18_19, CG_Discharge_20_21, 'Tail','right')

% hypothesis test comparing the discharge of 2018-2019 rain events only
% with the corresponding discharge data for 2020-2021
[h1, p1, ci, stats] = ttest2(BC_Discharge_18_19_Rain, BC_Discharge_20_21_Rain, 'Tail','right')
[h2, p2, ci, stats] = ttest2(CG_Discharge_18_19_Rain, CG_Discharge_20_21_Rain, 'Tail','right')

% hypothesis test comparing the discharge of 2018-2019 minus rain events
% with the corresponding discharge data for 2020-2021
[h3, p3, ci, stats] = ttest2(BC_Discharge_18_19_NoRain, BC_Discharge_20_21_NoRain, 'Tail','right')
[h4, p4, ci, stats] = ttest2(CG_Discharge_18_19_NoRain, CG_Discharge_20_21_NoRain, 'Tail','right')

BC_Avg_Rain1 = mean(BC_Discharge_18_19_Rain)
BC_Avg_Rain2 = mean(BC_Discharge_20_21_Rain)
CG_Avg_Rain1 = mean(CG_Discharge_18_19_Rain)
CG_Avg_Rain2 = mean(CG_Discharge_20_21_Rain)

BC_Avg_NoRain1 = mean(BC_Discharge_18_19_NoRain)
BC_Avg_NoRain2 = mean(BC_Discharge_20_21_NoRain)
CG_Avg_NoRain1 = mean(CG_Discharge_18_19_NoRain)
CG_Avg_NoRain2 = mean(CG_Discharge_20_21_NoRain)

% figure(1)
% subplot(2,1,1)
% plot(Precip_Data_18_19)
% subplot(2,1,2)
% plot(Ground_Sat_Data_18_19)
