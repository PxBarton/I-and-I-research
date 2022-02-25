% Importing Data into an m-file: 
% close all; 
% clear all; 
% clc

% Load Data into matrix form.
CG_Data = xlsread('Pump_Station_Flow.xlsx',1,'B2:J731');

CG_Month = CG_Data(:,1);
CG_Precip = CG_Data(:,9);
CG_Discharge = CG_Data(:,8);

% Total Discharge over 2018-2019:
CG_Total_Discharge = sum(CG_Discharge)

% Best Fit Regression Line: 
CG_Coeff = polyfit(CG_Precip,CG_Discharge,1);

% Stats on Precip: 
CG_Mean   = mean(CG_Precip);
CG_St_Dev = std(CG_Precip);
CG_MinPrecip    = min(CG_Precip);
CG_MaxPrecip    = max(CG_Precip);
CG_Quartiles = prctile(CG_Precip,[25 50 75]);

% Visual Representation:
% figure(1)
% hist(CG_Discharge,20)
% title('Histogram of Precipitation','fontsize',22,'interpreter','latex')
% xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
% ylabel('Frequency','fontsize',18,'interpreter','latex')
% grid on
% grid minor
% 
% figure(2)
% boxplot(CG_Discharge)
% title('Boxplot of Precipitation','fontsize',22,'interpreter','latex')
% xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
% ylabel('Frequency','fontsize',18,'interpreter','latex')
% grid on
% grid minor
% 
% figure(3)
% plot(CG_Precip,CG_Discharge,'ko','linewidth',5)
% title('Scatterplot of Discharge vs. Precipitation','fontsize',22,'interpreter','latex')
% xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
% ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
% grid on
% grid minor

