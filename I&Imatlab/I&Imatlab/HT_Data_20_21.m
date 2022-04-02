% Importing Data into an m-file: 
% close all; 
% clear all; 
% clc

% Load Data into matrix form.
HT_Data = xlsread('Current_Pump_Precip.xlsx',4,'A2:N274');

HT_Day = HT_Data(:,1);
HT_Month = HT_Data(:,2);
HT_Precip = HT_Data(:,11);
HT_Discharge = HT_Data(:,10);
HT_Ground_Sat = HT_Data(:,14);

% Finding the nans of of the precipitation vector:
HT_Precip_nan = find(isnan(HT_Precip)); 
x = 1:length(HT_Discharge);
x(HT_Precip_nan) = [];

% Total Discharge over 2018-2019:
HT_Total_Discharge = sum(HT_Discharge(x))

% Best Fit Regression Line: 
HT_Coeff = polyfit(HT_Precip(x),HT_Discharge(x),1);

% Stats on Precip: 
HT_Mean   = mean(HT_Precip(x));
HT_St_Dev = std(HT_Precip(x));
HT_MinPrecip    = min(HT_Precip(x));
HT_MaxPrecip    = max(HT_Precip(x));
HT_Quartiles = prctile(HT_Precip(x),[25 50 75]);

% Visual Representation:
% figure(1)
% hist(HT_Discharge,20)
% title('Histogram of Precipitation','fontsize',22,'interpreter','latex')
% xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
% ylabel('Frequency','fontsize',18,'interpreter','latex')
% grid on
% grid minor
% 
% figure(2)
% boxplot(HT_Discharge)
% title('Boxplot of Precipitation','fontsize',22,'interpreter','latex')
% xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
% ylabel('Frequency','fontsize',18,'interpreter','latex')
% grid on
% grid minor
% 
% figure(3)
% plot(HT_Precip,HT_Discharge,'ko','linewidth',5)
% title('Scatterplot of Discharge vs. Precipitation: Hilltop','fontsize',20,'interpreter','latex')
% xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
% ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
% grid on
% grid minor

