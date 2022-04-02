% Importing Data into an m-file: 
% close all; 
% clear all; 
% clc

% Load Data into matrix form.
BC_Data = xlsread('Pump_Station_Flow.xlsx',3,'B2:J731');

BC_Month = BC_Data(:,1);
BC_Precip = BC_Data(:,8);
BC_Discharge = BC_Data(:,7);

% Total Discharge over 2018-2019:
BC_Total_Discharge = sum(BC_Discharge)

% Best Fit Regression Line: 
BC_Coeff = polyfit(BC_Precip,BC_Discharge,1);

% Stats on Precip: 
BC_Mean   = mean(BC_Precip);
BC_St_Dev = std(BC_Precip);
BC_MinPrecip    = min(BC_Precip);
BC_MaxPrecip    = max(BC_Precip);
BC_Quartiles = prctile(BC_Precip,[25 50 75]);

% Visual Representation:
% figure(1)
% hist(BC_Discharge,20)
% title('Histogram of Precipitation','fontsize',22,'interpreter','latex')
% xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
% ylabel('Frequency','fontsize',18,'interpreter','latex')
% grid on
% grid minor
% 
% figure(2)
% boxplot(BC_Discharge)
% title('Boxplot of Precipitation','fontsize',22,'interpreter','latex')
% xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
% ylabel('Frequency','fontsize',18,'interpreter','latex')
% grid on
% grid minor
% 
% figure(3)
% plot(BC_Precip,BC_Discharge,'ko','linewidth',5)
% title('Scatterplot of Discharge vs. Precipitation: Briar Cliff','fontsize',20,'interpreter','latex')
% xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
% ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
% grid on
% grid minor

