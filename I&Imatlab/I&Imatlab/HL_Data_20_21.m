% Importing Data into an m-file: 
% close all; 
% clear all; 
% clc

% Load Data into matrix form.
HL_Data = xlsread('Current_Pump_Precip.xlsx',3,'A2:N274');

HL_Day = HL_Data(:,1);
HL_Month = HL_Data(:,2);
HL_Precip = HL_Data(:,11);
HL_Discharge = HL_Data(:,10);
HL_Ground_Sat = HL_Data(:,14);

% Finding the nans of of the precipitation vector:
HL_Precip_nan = find(isnan(HL_Precip)); 
x = 1:length(HL_Discharge);
x(HL_Precip_nan) = [];

% Total Discharge over 2018-2019:
HL_Total_Discharge = sum(HL_Discharge(x))

% Best Fit Regression Line: 
HL_Coeff = polyfit(HL_Precip(x),HL_Discharge(x),1);


% Stats on Precip: 
HL_Mean   = mean(HL_Precip(x));
HL_St_Dev = std(HL_Precip(x));
HL_MinPrecip    = min(HL_Precip(x));
HL_MaxPrecip    = max(HL_Precip(x));
HL_Quartiles = prctile(HL_Precip(x),[25 50 75]);

% Visual Representation:
% figure(1)
% hist(HL_Discharge,20)
% title('Histogram of Precipitation','fontsize',22,'interpreter','latex')
% xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
% ylabel('Frequency','fontsize',18,'interpreter','latex')
% grid on
% grid minor
% 
% figure(2)
% boxplot(HL_Discharge)
% title('Boxplot of Precipitation','fontsize',22,'interpreter','latex')
% xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
% ylabel('Frequency','fontsize',18,'interpreter','latex')
% grid on
% grid minor
% 
% figure(3)
% plot(HL_Precip,HL_Discharge,'ko','linewidth',5)
% title('Scatterplot of Discharge vs. Precipitation: Highland','fontsize',20,'interpreter','latex')
% xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
% ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
% grid on
% grid minor

