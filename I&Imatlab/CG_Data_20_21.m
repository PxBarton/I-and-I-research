% Importing Data into an m-file: 
% (close all etc must remain commented out 
% for importing multiple pump station data files into Data_20_21_Import, 
% or each file erases the previously loaded data)
% close all; 
% clear all; 
% clc

% Load Data into matrix form.
CG_Data = xlsread('Current_Pump_Precip.xlsx',2,'A2:N274');

CG_Day = CG_Data(:,1);
CG_Month = CG_Data(:,3)
CG_Precip = CG_Data(:,11);
CG_Discharge = CG_Data(:,10);
CG_Ground_Sat = CG_Data(:,14);

% Finding the nans of of the precipitation vector:
CG_Precip_nan = find(isnan(CG_Precip)); 
x = 1:length(CG_Discharge);
x(CG_Precip_nan) = [];

% Total Discharge over 2018-2019:
CG_Total_Discharge = sum(CG_Discharge(x))

% Best Fit Regression Line: 
CG_Coeff = polyfit(CG_Precip(x),CG_Discharge(x),1);


% Stats on Precip: 
CG_Mean   = mean(CG_Precip(x));
CG_St_Dev = std(CG_Precip(x));
CG_MinPrecip    = min(CG_Precip(x));
CG_MaxPrecip    = max(CG_Precip(x));
CG_Quartiles = prctile(CG_Precip(x),[25 50 75]);

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

