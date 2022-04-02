% Importing Data into an m-file: 
% close all; 
% clear all; 
% clc

% Load Data into matrix form.
HL_Data = xlsread('Pump_Station_Flow.xlsx',5,'B2:J731');

HL_Month = HL_Data(:,1);
HL_Precip = HL_Data(:,8);
HL_Discharge = HL_Data(:,7);

% Total Discharge over 2018-2019:
HL_Total_Discharge = sum(HL_Discharge)

% Best Fit Regression Line: 
HL_Coeff = polyfit(HL_Precip,HL_Discharge,1);

% Stats on Precip: 
HL_Mean   = mean(HL_Precip);
HL_St_Dev = std(HL_Precip);
HL_MinPrecip    = min(HL_Precip);
HL_MaxPrecip    = max(HL_Precip);
HL_Quartiles = prctile(HL_Precip,[25 50 75]);

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

