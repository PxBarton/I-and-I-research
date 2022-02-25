% Importing Data into an m-file: 
close all; 
clear all; 
clc

% Load Data into matrix form.
HT_Data = xlsread('Pump_Station_Flow.xlsx',9,'B2:K731');

HT_Month = HT_Data(368:730,1);
HT_Precip = HT_Data(368:730,10);
HT_Discharge = HT_Data(368:730,9);

% Total Discharge over 2018-2019:
Total_Discharge = sum(HT_Discharge)

% Best Fit Regression Line: 
c = polyfit(HT_Precip,HT_Discharge,1);

% Stats on Precip: 
Mean   = mean(HT_Precip);
St_Dev = std(HT_Precip);
Min    = min(HT_Precip);
Max    = max(HT_Precip);
Quartiles = prctile(HT_Precip,[25 50 75]);

% Visual Representation:
figure(1)
hist(HT_Discharge,20)
title('Histogram of Precipitation','fontsize',22,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Frequency','fontsize',18,'interpreter','latex')
grid on
grid minor

figure(2)
boxplot(HT_Discharge)
title('Boxplot of Precipitation','fontsize',22,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Frequency','fontsize',18,'interpreter','latex')
grid on
grid minor

figure(3)
plot(HT_Precip,HT_Discharge,'ko','linewidth',5)
title('Scatterplot of Discharge vs. Precipitation: Hilltop','fontsize',20,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor

