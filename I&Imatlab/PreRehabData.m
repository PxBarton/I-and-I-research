% Importing Data into an m-file: 
close all; 
clear all; 
clc

% Load Data into matrix form.

%BC_Post = readmatrix('Post_PS_Stations_by_Sheet.xlsx',...
%                    'Sheet','BriarCliff','Range','B2:K427');
%BC_Pre  = readmatrix('Pre_PS_Stations_by_Sheet.xlsx',...
%                     'Sheet','BriarCliff','Range','B2:K762');

%BC_TD_Post = cell(1,12);
%BC_TD_Pre = cell(1,12);

BC_Pre  = readmatrix('Pre_PS_Stations_by_Sheet.xlsx',...
                    'Sheet','BriarCliff','Range','B2:K762');
                
CG_Pre  = readmatrix('Pre_PS_Stations_by_Sheet.xlsx',...
                    'Sheet','CollegeGardens','Range','B2:K762');
                
HL_Pre  = readmatrix('Pre_PS_Stations_by_Sheet.xlsx',...
                    'Sheet','Highland','Range','B2:K762');

HT_Pre  = readmatrix('Pre_PS_Stations_by_Sheet.xlsx',...
                    'Sheet','Hilltop','Range','B2:K397');
                

Pre_Precip = readmatrix('Pre_PS_Stations_by_Sheet.xlsx',...
                    'Sheet','Precipitation','Range','A2:G762');
                        
                
Precip_Data = Pre_Precip(:, 6);
Ground_Sat_Data = Pre_Precip(:, 7);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Briar Cliff Stats

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

BC_Discharge = BC_Pre(:, 10);

% Coefficients and R^2 for Precipitation vs Pump Discharge
BC_Precip_Coeff = polyfit(Precip_Data, BC_Discharge, 1)
BC_Precip_Fit = polyval(BC_Precip_Coeff, Precip_Data);

BC_Precip_Rsq = 1 - sum((BC_Discharge - BC_Precip_Fit).^2) / ...
    sum((BC_Discharge - mean(BC_Discharge)).^2)

corrcoef(BC_Discharge, BC_Precip_Fit).^2

% Coefficients and R^2 for Groound Saturation vs Pump Discharge
BC_GSat_Coeff = polyfit(Ground_Sat_Data, BC_Discharge, 1)
BC_GSat_Fit = polyval(BC_GSat_Coeff, Ground_Sat_Data);

BC_GSat_Rsq = 1 - sum((BC_Discharge - BC_GSat_Fit).^2) / ...
    sum((BC_Discharge - mean(BC_Discharge)).^2)

corrcoef(BC_Discharge, BC_GSat_Fit).^2


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% College Garden Stats

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CG_Discharge = CG_Pre(:, 10);

% Coefficients and R^2 for Precipitation vs Pump Discharge
CG_Precip_Coeff = polyfit(Precip_Data, CG_Discharge, 1)
CG_Precip_Fit = polyval(CG_Precip_Coeff, Precip_Data);

CG_Precip_Rsq = 1 - sum((CG_Discharge - CG_Precip_Fit).^2) / ...
    sum((CG_Discharge - mean(CG_Discharge)).^2)

corrcoef(CG_Discharge, CG_Precip_Fit).^2

% Coefficients and R^2 for Groound Saturation vs Pump Discharge
CG_GSat_Coeff = polyfit(Ground_Sat_Data, CG_Discharge, 1)
CG_GSat_Fit = polyval(CG_GSat_Coeff, Ground_Sat_Data);

CG_GSat_Rsq = 1 - sum((CG_Discharge - CG_GSat_Fit).^2) / ...
    sum((CG_Discharge - mean(CG_Discharge)).^2)

corrcoef(CG_Discharge, CG_GSat_Fit).^2


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Highland Stats

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

HL_Discharge = HL_Pre(:, 10);

% Coefficients and R^2 for Precipitation vs Pump Discharge
HL_Precip_Coeff = polyfit(Precip_Data, HL_Discharge, 1)
HL_Precip_Fit = polyval(HL_Precip_Coeff, Precip_Data);

HL_Precip_Rsq = 1 - sum((HL_Discharge - HL_Precip_Fit).^2) / ...
    sum((HL_Discharge - mean(HL_Discharge)).^2)

corrcoef(HL_Discharge, HL_Precip_Fit).^2

% Coefficients and R^2 for Groound Saturation vs Pump Discharge
HL_GSat_Coeff = polyfit(Ground_Sat_Data, HL_Discharge, 1)
HL_GSat_Fit = polyval(HL_GSat_Coeff, Ground_Sat_Data);

HL_GSat_Rsq = 1 - sum((BC_Discharge - HL_GSat_Fit).^2) / ...
    sum((HL_Discharge - mean(HL_Discharge)).^2)

corrcoef(HL_Discharge, HL_GSat_Fit).^2


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Hilltop Stats

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

HT_Discharge = HT_Pre(:, 9);

% Coefficients and R^2 for Precipitation vs Pump Discharge
%HT_Precip_Coeff = polyfit(Precip_Data, HT_Discharge, 1)
%HT_Precip_Fit = polyval(HT_Precip_Coeff, Precip_Data);

%HT_Precip_Rsq = 1 - sum((HT_Discharge - HT_Precip_Fit).^2) / ...
%    sum((HT_Discharge - mean(HT_Discharge)).^2)

%corrcoef(HT_Discharge, HT_Precip_Fit).^2

% Coefficients and R^2 for Groound Saturation vs Pump Discharge
HT_GSat_Coeff = polyfit(Ground_Sat_Data(366:761), HT_Discharge, 1)
HT_GSat_Fit = polyval(HT_GSat_Coeff, Ground_Sat_Data(366:761));

HT_GSat_Rsq = 1 - sum((HT_Discharge - HT_GSat_Fit).^2) / ...
    sum((HT_Discharge - mean(HT_Discharge)).^2)

corrcoef(HT_Discharge, HT_GSat_Fit).^2



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
plot(Ground_Sat_Data(366:761), HT_Discharge,'ko','linewidth',5)
hold on
plot(Ground_Sat_Data(366:761), HT_GSat_Fit,'b-','linewidth',2)
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
xlim([1 761])
title('Briar Cliff Discharge 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Gallons','fontsize',14,'interpreter','latex')
subplot(5,1,2)
plot(CG_Discharge)
xlim([1 761])
title('College Gardens Discharge 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Gallons','fontsize',14,'interpreter','latex')
subplot(5,1,3)
plot(HL_Discharge)
xlim([1 761])
title('Highland Discharge 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Gallons','fontsize',14,'interpreter','latex')
subplot(5,1,4)
plot(Precip_Data)
xlim([1 761])
title('Precipitation 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
subplot(5,1,5)
plot(Ground_Sat_Data)
xlim([1 761])
title('Ground Saturation 2018-2019', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
set(gcf,'Position',[100 100 540 800])
%fig = gcf;
%exportgraphics(fig, 'timeseries_18_19_BC.png', 'Resolution', 300)

figure(9)
%title('Hilltop', 'fontsize', 20)
subplot(3,1,1)
plot(HT_Discharge)
xlim([1 357])
title('Hilltop Discharge 2019-2020', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Gallons','fontsize',14,'interpreter','latex')
subplot(3,1,2)
plot(Precip_Data(366:761))
xlim([1 396])
title('Precipitation 2019-2020', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
subplot(3,1,3)
plot(Ground_Sat_Data(366:761))
xlim([1 396])
title('Ground Saturation 2019-2020', 'fontsize', 18, 'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
set(gcf,'Position',[100 100 540 500])
%fig = gcf;
%exportgraphics(fig, 'timeseries_18_19_HT.png', 'Resolution', 300)

