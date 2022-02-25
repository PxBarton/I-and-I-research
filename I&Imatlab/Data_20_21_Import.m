% Import all data into an .m file
close all;
clear all;
clc

% Calling individual data import .m files
BC_Data_20_21
CG_Data_20_21
HL_Data_20_21
HT_Data_20_21

% Create linear fit and find R^2
BC_Best_Fit = polyval(BC_Coeff,BC_Precip(x));
CG_Best_Fit = polyval(CG_Coeff,CG_Precip(x));
HL_Best_Fit = polyval(HL_Coeff,HL_Precip(x));
HT_Best_Fit = polyval(HT_Coeff,HT_Precip(x));



% Briar Cliff R^2 using the standard formula and corrcoef()
BC_Rsq = 1 - sum((BC_Discharge(x) - BC_Best_Fit).^2) / ...
    sum((BC_Discharge(x) - mean(BC_Discharge(x))).^2)

corrcoef(BC_Discharge(x), BC_Best_Fit).^2

% College Gardens R^2 using the standard formula and corrcoef()
CG_Rsq = 1 - sum((CG_Discharge(x) - CG_Best_Fit).^2) / ...
    sum((BC_Discharge(x) - mean(BC_Discharge(x))).^2);

corrcoef(CG_Discharge(x), CG_Best_Fit).^2;

% Highland R^2 using the standard formula and corrcoef()
HL_Rsq = 1 - sum((HL_Discharge(x) - HL_Best_Fit).^2) / ...
    sum((HL_Discharge(x) - mean(HL_Discharge(x))).^2)

corrcoef(HL_Discharge(x), HL_Best_Fit).^2

% Hilltop R^2 using the standard formula and corrcoef()
HT_Rsq = 1 - sum((HT_Discharge(x) - HT_Best_Fit).^2) / ...
    sum((HT_Discharge(x) - mean(HT_Discharge(x))).^2);

corrcoef(HT_Discharge(x), HT_Best_Fit).^2;



% Visual representation
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
%fig = gfc;
% exportgraphics(fig, 'histograms_20_21.jpg', 'Resolution', 300)

% boxplots
figure(2)
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
%fig = gfc;
% exportgraphics(fig, 'boxplots_20_21.jpg', 'Resolution', 300)

% scatterplots
figure(3)
subplot(2,2,1)
plot(BC_Precip(x),BC_Discharge(x),'ko','linewidth',3)
hold on
plot(BC_Precip(x),BC_Best_Fit,'b-','linewidth',2)
title('Discharge vs. Precipitation: Briar Cliff','fontsize',20,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,2)
plot(CG_Precip,CG_Discharge,'ko','linewidth',3)
hold on
plot(CG_Precip(x),CG_Best_Fit,'b-','linewidth',2)
title('Discharge vs. Precipitation: College Gardens','fontsize',20,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,3)
plot(HL_Precip,HL_Discharge,'ko','linewidth',3)
hold on
plot(HL_Precip(x),HL_Best_Fit,'b-','linewidth',2)
title('Discharge vs. Precipitation: Highland','fontsize',20,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,4)
plot(HT_Precip,HT_Discharge,'ko','linewidth',3)
hold on
plot(HT_Precip(x),HT_Best_Fit,'b-','linewidth',2)
title('Discharge vs. Precipitation: Hilltop','fontsize',20,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
%fig = gfc
%exportgraphics(fig, 'scatterplots_20_21.jpg', 'Resolution', 300)

% Plot of Discharge vs. Day
figure(4)
subplot(2,2,1)
plot(x,BC_Discharge(x),'k','linewidth',2)
title('Discharge vs. Day: Briar Cliff','fontsize',20,'interpreter','latex')
xlabel('Days since Nov 1 2020','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,2)
plot(x,CG_Discharge(x),'k','linewidth',2)
title('Discharge vs. Day: College Gardens','fontsize',20,'interpreter','latex')
xlabel('Days since Nov 1 2020','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,3)
plot(x,HL_Discharge(x),'k','linewidth',2)
title('Discharge vs. Day: Highland','fontsize',20,'interpreter','latex')
xlabel('Days since Nov 1 2020','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,4)
plot(x,HT_Discharge(x),'k','linewidth',2)
title('Discharge vs. Day: Hill Top','fontsize',20,'interpreter','latex')
xlabel('Days since Nov 1 2020','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
% fig = gfc
% exportgraphics(fig, 'discharge_day_20_21.jpg', 'Resolution', 300)

ind = find(isnan(BC_Ground_Sat)==0);

BC_GroundSat_Coeff = polyfit(BC_Ground_Sat(ind), BC_Discharge(ind), 1);
CG_GroundSat_Coeff = polyfit(CG_Ground_Sat(ind), CG_Discharge(ind), 1);
HL_GroundSat_Coeff = polyfit(HL_Ground_Sat(ind), HL_Discharge(ind), 1);
HT_GroundSat_Coeff = polyfit(HT_Ground_Sat(ind), HT_Discharge(ind), 1);


% Create linear fit and find R^2 for ground saturation vs discharge
BC_GroundSat_Fit = polyval(BC_GroundSat_Coeff, BC_Ground_Sat(ind));
CG_GroundSat_Fit = polyval(CG_GroundSat_Coeff, BC_Ground_Sat(ind));
HL_GroundSat_Fit = polyval(HL_GroundSat_Coeff, BC_Ground_Sat(ind));
HT_GroundSat_Fit = polyval(HT_GroundSat_Coeff, BC_Ground_Sat(ind));

% scatterplots discharge vs ground saturation
figure(5)
subplot(2,2,1)
plot(BC_Ground_Sat(ind),BC_Discharge(ind),'ko','linewidth',3)
hold on
plot(BC_Ground_Sat(ind),BC_GroundSat_Fit,'b-','linewidth',2)
title('Briar Cliff','fontsize',20,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,2)
plot(BC_Ground_Sat(ind),CG_Discharge(ind),'ko','linewidth',3)
hold on
plot(BC_Ground_Sat(ind),CG_GroundSat_Fit,'b-','linewidth',2)
title('College Gardens','fontsize',20,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,3)
plot(BC_Ground_Sat(ind),HL_Discharge(ind),'ko','linewidth',3)
hold on
plot(BC_Ground_Sat(ind),HL_GroundSat_Fit,'b-','linewidth',2)
title('Highland','fontsize',20,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
subplot(2,2,4)
plot(BC_Ground_Sat(ind),HT_Discharge(ind),'ko','linewidth',3)
hold on
plot(BC_Ground_Sat(ind),HT_GroundSat_Fit,'b-','linewidth',2)
title('Hilltop','fontsize',20,'interpreter','latex')
xlabel('Precipitation (inches)','fontsize',18,'interpreter','latex')
ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
grid on
grid minor
set(gcf,'Position',[100 100 800 700])
% fig = gfc
% exportgraphics(fig, 'discharge_groundsat_20_21.jpg', 'Resolution, 300)


% Briar Cliff R^2 using the standard formula and corrcoef()
BC_Rsq_GroundSat = 1 - sum((BC_Discharge(ind) - BC_GroundSat_Fit).^2) / ...
    sum((BC_Discharge(ind) - mean(BC_Discharge(ind))).^2)

corrcoef(BC_Discharge(ind), BC_GroundSat_Fit).^2

% College Gardens R^2 using the standard formula and corrcoef()
CG_Rsq_GroundSat = 1 - sum((CG_Discharge(ind) - CG_GroundSat_Fit).^2) / ...
    sum((CG_Discharge(ind) - mean(CG_Discharge(ind))).^2)

corrcoef(CG_Discharge(ind), CG_GroundSat_Fit).^2

% Highland R^2 using the standard formula and corrcoef()
HL_Rsq_GroundSat = 1 - sum((HL_Discharge(ind) - HL_GroundSat_Fit).^2) / ...
    sum((HL_Discharge(ind) - mean(HL_Discharge(ind))).^2)

corrcoef(HL_Discharge(ind), HL_GroundSat_Fit).^2

% Hilltop R^2 using the standard formula and corrcoef()
HT_Rsq_GroundSat = 1 - sum((HT_Discharge(ind) - HT_GroundSat_Fit).^2) / ...
    sum((HT_Discharge(ind) - mean(HT_Discharge(ind))).^2)

corrcoef(HT_Discharge(ind), HT_GroundSat_Fit).^2


figure(6)
title('Briar Cliff', 'fontsize', 20)
subplot(5,1,1)
plot(BC_Discharge(ind))
xlim([1 259])
title('Briar Cliff Discharge 2020-2021', 'fontsize', 18,'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Gallons','fontsize',14,'interpreter','latex')
subplot(5,1,2)
plot(CG_Discharge(ind))
xlim([1 259])
title('College Gardens Discharge 2020-2021', 'fontsize', 18,'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Gallons','fontsize',14,'interpreter','latex')
subplot(5,1,3)
plot(HL_Discharge(ind))
xlim([1 259])
title('Highland Discharge 2020-2021', 'fontsize', 18,'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Gallons','fontsize',14,'interpreter','latex')
subplot(5,1,4)
plot(BC_Precip(ind))
xlim([1 259])
title('Precipitation 2020-2021', 'fontsize', 18,'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
subplot(5,1,5)
plot(BC_Ground_Sat(ind))
xlim([1 259])
title('Ground Saturation 2020-2021', 'fontsize', 18,'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
set(gcf,'Position',[100 100 540 800])
% fig = gfc
% exportgraphics(fig, 'BC_Precip_Discharge_20_21.jpg', 'Resolution, 300)

figure(7)
title('College Gardens', 'fontsize', 20)
subplot(3,1,1)
plot(CG_Discharge(ind))
title('College Gardens Discharge 2020-2021', 'fontsize', 18,'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Gallons','fontsize',14,'interpreter','latex')
subplot(3,1,2)
plot(CG_Precip(ind))
title('College Gardens Precipitation 2020-2021', 'fontsize', 18,'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
subplot(3,1,3)
plot(CG_Ground_Sat(ind))
title('College Gardens Ground Saturation 2020-2021', 'fontsize', 18,'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
set(gcf,'Position',[100 100 540 500])
% fig = gfc
% exportgraphics(fig, 'CG_Precip_Discharge_20_21.jpg', 'Resolution, 300)


figure(8)
subplot(3,1,1)
plot(HL_Discharge(ind))
title('Highland Discharge 2020-2021', 'fontsize', 18,'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Gallons','fontsize',14,'interpreter','latex')
subplot(3,1,2)
plot(HL_Precip(ind))
title('Highland Precipitation 2020-2021', 'fontsize', 18,'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
subplot(3,1,3)
plot(HL_Ground_Sat(ind))
title('Highland Ground Saturation 2020-2021', 'fontsize', 18,'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
set(gcf,'Position',[100 100 540 500])
% fig = gfc
% exportgraphics(fig, 'HL_Precip_Discharge_20_21.jpg', 'Resolution, 300)


figure(9)
title('Hilltop', 'fontsize', 20)
subplot(3,1,1)
plot(HT_Discharge(ind))
xlim([1 253])
title('Hilltop Discharge 2020-2021', 'fontsize', 18,'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Gallons','fontsize',14,'interpreter','latex')
subplot(3,1,2)
plot(HT_Precip(ind))
xlim([1 253])
title('Precipitation 2020-2021', 'fontsize', 18,'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
subplot(3,1,3)
plot(HT_Ground_Sat(ind))
xlim([1 253])
title('Ground Saturation 2020-2021', 'fontsize', 18,'interpreter','latex')
xlabel('Days','fontsize',14,'interpreter','latex')
ylabel('Inches','fontsize',14,'interpreter','latex')
set(gcf,'Position',[100 100 540 500])
% fig = gfc
% exportgraphics(fig, 'HT_Precip_Discharge_20_21.jpg', 'Resolution, 300)


