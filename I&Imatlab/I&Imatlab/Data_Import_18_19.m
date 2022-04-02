% Import all data into an .m file
close all;
clear all;
clc

% Calling individual data import .m files
BC_Data_Import
CG_Data_Import
HL_Data_Import
HTcontrol_June_1

% Ground saturation data 
Ground_Sat_Data = xlsread('Pump_Station_Flow.xlsx',10,'F2:F731');
HT_GSat_Data = Ground_Sat_Data(368:730)

% Create linear fit and find R^2 for discharge vs precipitation
BC_Fit = polyval(BC_Coeff, BC_Precip);
CG_Fit = polyval(CG_Coeff, CG_Precip);
HL_Fit = polyval(HL_Coeff, HL_Precip);
HT_Fit = polyval(HT_Coeff, HT_Precip(x));

BC_Rsq = 1 - sum((BC_Discharge - BC_Fit).^2) / ...
    sum((BC_Discharge - mean(BC_Discharge)).^2)

corrcoef(BC_Discharge, BC_Fit).^2

CG_Rsq = 1 - sum((CG_Discharge - CG_Fit).^2) / ...
    sum((CG_Discharge - mean(CG_Discharge)).^2)

corrcoef(CG_Discharge, CG_Fit).^2

HL_Rsq = 1 - sum((HL_Discharge - HL_Fit).^2) / ...
    sum((HL_Discharge - mean(HL_Discharge)).^2)

corrcoef(HL_Discharge, HL_Fit).^2

HT_Rsq = 1 - sum((HT_Discharge(x) - HT_Fit).^2) / ...
    sum((HT_Discharge(x) - mean(HT_Discharge(x))).^2)

corrcoef(HT_Discharge(x), HT_Fit).^2


% Best Fit Regression Lines for discharge vs ground saturation: 
BC_GSat_Coeff = polyfit(Ground_Sat_Data, BC_Discharge,1);
CG_GSat_Coeff = polyfit(Ground_Sat_Data, CG_Discharge,1);
HL_GSat_Coeff = polyfit(Ground_Sat_Data, HL_Discharge,1);
HT_GSat_Coeff = polyfit(HT_GSat_Data(x), HT_Discharge(x),1);

% Create linear fit and find R^2 for discharge vs ground saturation
BC_GSat_Fit = polyval(BC_GSat_Coeff, Ground_Sat_Data);
CG_GSat_Fit = polyval(CG_GSat_Coeff, Ground_Sat_Data);
HL_GSat_Fit = polyval(HL_GSat_Coeff, Ground_Sat_Data);
HT_GSat_Fit = polyval(HT_GSat_Coeff, Ground_Sat_Data(x));

BC_GSat_Rsq = 1 - sum((BC_Discharge - BC_GSat_Fit).^2) / ...
    sum((BC_Discharge - mean(BC_Discharge)).^2)

corrcoef(BC_Discharge, BC_GSat_Fit).^2

CG_GSat_Rsq = 1 - sum((CG_Discharge - CG_GSat_Fit).^2) / ...
    sum((CG_Discharge - mean(CG_Discharge)).^2)

corrcoef(CG_Discharge, CG_GSat_Fit).^2

HL_GSat_Rsq = 1 - sum((HL_Discharge - HL_GSat_Fit).^2) / ...
    sum((HL_Discharge - mean(HL_Discharge)).^2)

corrcoef(HL_Discharge, HL_GSat_Fit).^2

HT_GSat_Rsq = 1 - sum((HT_Discharge(x) - HT_GSat_Fit).^2) / ...
    sum((HT_Discharge(x) - mean(HT_Discharge(x))).^2)

corrcoef(HT_Discharge(x), HT_GSat_Fit).^2



% Visual Representation:
% histograms
figure(1)
subplot(2,2,1)
hist(CG_Discharge,20)
title('Histogram of College Garden Discharge','fontsize',22,'interpreter','latex')
xlabel('Total Discharge (gallons)','fontsize',18,'interpreter','latex')
ylabel('Frequency','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,2)
hist(BC_Discharge,20)
title('Histogram of Briar Cliff Discharge','fontsize',22,'interpreter','latex')
xlabel('Total Discharge (gallons)','fontsize',18,'interpreter','latex')
ylabel('Frequency','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,3)
hist(HL_Discharge,20)
title('Histogram of Highland Discharge','fontsize',22,'interpreter','latex')
xlabel('Total Discharge (gallons)','fontsize',18,'interpreter','latex')
ylabel('Frequency','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,4)
hist(HT_Discharge,20)
title('Histogram of Hilltop Discharge','fontsize',22,'interpreter','latex')
xlabel('Total Discharge (gallons)','fontsize',18,'interpreter','latex')
ylabel('Frequency','fontsize',18,'interpreter','latex')
grid on
grid minor
%fig = gcf;
%exportgraphics(fig,'histograms_18_19.png', 'Resolution',300)

% boxplots
figure(1)
subplot(2,2,1)
boxplot(BC_Discharge)
title('Boxplot of Precipitation','fontsize',22,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Frequency','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,2)
boxplot(CG_Discharge)
title('Boxplot of Precipitation','fontsize',22,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Frequency','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,3)
boxplot(HL_Discharge)
title('Boxplot of Precipitation','fontsize',22,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Frequency','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,4)
boxplot(HT_Discharge)
title('Boxplot of Precipitation','fontsize',22,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Frequency','fontsize',18,'interpreter','latex')
grid on
grid minor
%fig = gcf;
%exportgraphics(fig, 'boxplots_18_19.png', 'Resolution', 300)

% Discharge vs Precip
figure(3)
subplot(2,2,1)
plot(BC_Precip,BC_Discharge,'ko','linewidth',5)
hold on
plot(BC_Precip,BC_Fit,'b-','linewidth',2)
title('Scatterplot of Discharge vs. Precipitation: Briar Cliff','fontsize',20,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,2)
plot(CG_Precip,CG_Discharge,'ko','linewidth',5)
hold on
plot(CG_Precip,CG_Fit,'b-','linewidth',2)
title('Scatterplot of Discharge vs. Precipitation','fontsize',22,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,3)
plot(HL_Precip,HL_Discharge,'ko','linewidth',5)
hold on
plot(HL_Precip,HL_Fit,'b-','linewidth',2)
title('Scatterplot of Discharge vs. Precipitation: Highland','fontsize',20,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,4)
plot(HT_Precip(x),HT_Discharge(x),'ko','linewidth',5)
hold on
plot(HT_Precip(x),HT_Fit,'b-','linewidth',2)
title('Scatterplot of Discharge vs. Precipitation: Hilltop','fontsize',20,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
%fig = gfc;
%exportgraphics(fig, 'scatterplots_18_19.png', 'Resolution', 300)

% Discharge vs Ground Saturation
figure(4)
% title('Scatterplot of Discharge vs. Ground Saturation: Briar Cliff','fontsize',18,'interpreter','latex')
subplot(2,2,1)
plot(Ground_Sat_Data, BC_Discharge,'ko','linewidth',5)
hold on
plot(Ground_Sat_Data,BC_GSat_Fit,'b-','linewidth',2)
title('Briar Cliff','fontsize',18,'interpreter','latex')
xlabel('Ground Saturation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,2)
plot(Ground_Sat_Data, CG_Discharge,'ko','linewidth',5)
hold on
plot(Ground_Sat_Data,CG_GSat_Fit,'b-','linewidth',2)
title('College Gardens','fontsize',18,'interpreter','latex')
xlabel('Ground Saturation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,3)
plot(Ground_Sat_Data, HL_Discharge,'ko','linewidth',5)
hold on
plot(Ground_Sat_Data, HL_GSat_Fit,'b-','linewidth',2)
title('Highland','fontsize',18,'interpreter','latex')
xlabel('Ground Saturation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,4)
plot(HT_GSat_Data(x), HT_Discharge(x),'ko','linewidth',5)
hold on
plot(HT_GSat_Data(x), HT_GSat_Fit,'b-','linewidth',2)
title('Hilltop','fontsize',18,'interpreter','latex')
xlabel('Ground Saturation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
set(gcf,'Position',[100 100 800 700])
%fig = gcf;
%exportgraphics(fig, 'scatterplots_18_19_2.png', 'Resolution', 300)

figure(6)
title('Briar Cliff', 'fontsize', 20)
subplot(5,1,1)
plot(BC_Discharge)
xlim([1 730])
title('Briar Cliff Discharge 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Gallons','fontsize',14,'interpreter','latex')
subplot(5,1,2)
plot(CG_Discharge)
xlim([1 730])
title('College Gardens Discharge 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Gallons','fontsize',14,'interpreter','latex')
subplot(5,1,3)
plot(HL_Discharge)
xlim([1 730])
title('Highland Discharge 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Gallons','fontsize',14,'interpreter','latex')
subplot(5,1,4)
plot(BC_Precip)
xlim([1 730])
title('Precipitation 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
subplot(5,1,5)
plot(Ground_Sat_Data)
xlim([1 730])
title('Ground Saturation 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
set(gcf,'Position',[100 100 540 800])
%fig = gcf;
%exportgraphics(fig, 'timeseries_18_19_BC.png', 'Resolution', 300)


figure(7)
title('College Gardens', 'fontsize', 20)
subplot(3,1,1)
plot(CG_Discharge)
xlim([1 730])
title('College Gardens Discharge 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Gallons','fontsize',14,'interpreter','latex')
subplot(3,1,2)
plot(CG_Precip)
xlim([1 730])
title('College Gardens Precipitation 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
subplot(3,1,3)
plot(Ground_Sat_Data)
xlim([1 730])
title('College Gardens Ground Saturation 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
set(gcf,'Position',[100 100 540 500])
%fig = gcf;
%exportgraphics(fig, 'timeseries_18_19_CG.png', 'Resolution', 300)

figure(8)
subplot(3,1,1)
plot(HL_Discharge)
xlim([1 730])
title('Highland Discharge 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Gallons','fontsize',14,'interpreter','latex')
subplot(3,1,2)
plot(HL_Precip)
xlim([1 730])
title('Highland Precipitation 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
subplot(3,1,3)
plot(Ground_Sat_Data)
xlim([1 730])
title('Highland Ground Saturation 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
grid on 
grid minor
set(gcf,'Position',[100 100 540 500])
%fig = gcf;
%exportgraphics(fig, 'timeseries_18_19_HL.png', 'Resolution', 300)

figure(9)
%title('Hilltop', 'fontsize', 20)
subplot(3,1,1)
plot(HT_Discharge(x))
xlim([1 357])
title('Hilltop Discharge 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Gallons','fontsize',14,'interpreter','latex')
subplot(3,1,2)
plot(HT_Precip(x))
xlim([1 357])
title('Precipitation 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
subplot(3,1,3)
plot(HT_GSat_Data(x))
xlim([1 357])
title('Ground Saturation 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
set(gcf,'Position',[100 100 540 500])
%fig = gcf;
%exportgraphics(fig, 'timeseries_18_19_HT.png', 'Resolution', 300)