% Importing Data into an m-file: 
% close all; 
% clear all; 
% clc

% Load Data into matrix form.
BC_Data = xlsread('Current_Pump_Precip.xlsx',1,'A2:N274');

BC_Day = BC_Data(:,1);
BC_Month = BC_Data(:,3);
BC_Precip = BC_Data(:,11);
BC_Discharge = BC_Data(:,10);
BC_Ground_Sat = BC_Data(:,14);

% Finding the nans of of the precipitation vector:
BC_Precip_nan = find(isnan(BC_Precip)); 
x = 1:length(BC_Discharge);
x(BC_Precip_nan) = [];

% Total Discharge over 2018-2019:
BC_Total_Discharge = sum(BC_Discharge(x))

% Best Fit Regression Line: 
BC_Coeff = polyfit(BC_Precip(x),BC_Discharge(x),1);


% Stats on Precip: 
BC_Mean   = mean(BC_Precip(x));
BC_St_Dev = std(BC_Precip(x));
BC_MinPrecip    = min(BC_Precip(x));
BC_MaxPrecip    = max(BC_Precip(x));
BC_Quartiles = prctile(BC_Precip(x),[25 50 75]);

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

% figure(1)
% probplot(BC_Precip(x))
% 
% figure(2)
% probplot(BC_Discharge(x))
