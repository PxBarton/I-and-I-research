% Attempting to understand relationship between precipitation,
% ground saturation, and pump discarge

% Partitioning precipitation data into 'heavy' and 'medium' rain events
% looking for greater correlation with discharge during heavy events

% Introduced a progressive offset in the Highland pump station
% discharge data, looking for a noticeable increase in correlation
% (measured by corrcoef and R^2 values) 

clear all;
close all;
clc;

% Ground Saturation for 2018-2019
Ground_Sat_Data = xlsread('Pump_Station_Flow.xlsx',10,'F2:F731');

% create sets of indices for heavy rain event days
a = (215:235)';
b = (305:320)';
c = (565:575)';
d = (665:680)';

% create sets of indices for medium rain event days
e = (50:85)';
f = (140:150)';
g = (360:375)';
h = (470:480)';
i = (500:510)';
j = (535:550)';

% create a vector of indices for heavy rain events 
Heavy_Days = [a;b;c;d];


% create a vector of indices for medium + heavy rain events
Medium_Days = [a;b;c;d;e;f;g;h;i;j];

Heavy_GSat = Ground_Sat_Data(Heavy_Days);

Medium_GSat = Ground_Sat_Data(Medium_Days);




% Briar Cliff 2018-2019
% Load Data into matrix form.
BC_Data = xlsread('Pump_Station_Flow.xlsx',3,'B2:J731');
BC_Discharge = BC_Data(:,7);
BC_Heavy_Discharge = BC_Discharge(Heavy_Days);
BC_Medium_Discharge = BC_Discharge(Medium_Days);

% for loop through parameters to max R^2
for m = 5.0:-0.25:3.0
    m
    for n = 1:5
        n
        Extra = zeros(n,1);
        Heavy_Days2 = Ground_Sat_Data > m;
        Heavy_Days_Delay = Heavy_Days2(n:end);
        Heavy_GSat2 = Ground_Sat_Data(Heavy_Days2);
        BC_Heavy_Discharge2 = BC_Discharge(Heavy_Days_Delay); 
        BC_Coeff_Heavy2 = polyfit(Heavy_GSat2,BC_Heavy_Discharge2,1);
        BC_Fit_Heavy2 = polyval(BC_Coeff_Heavy2, Heavy_GSat2);
        corrcoef(BC_Heavy_Discharge2, BC_Fit_Heavy2).^2
    end;
 
end;

% Total Discharge over 2018-2019:
%BC_Total_Discharge = sum(BC_Discharge);

% Best Fit Regression Line: 
BC_Coeff_Heavy = polyfit(Heavy_GSat,BC_Heavy_Discharge,1);
BC_Coeff_Medium = polyfit(Medium_GSat, BC_Medium_Discharge,1);

% College Gardens 2018-2019
% Load Data into matrix form.
CG_Data = xlsread('Pump_Station_Flow.xlsx',1,'B2:J731');
CG_Discharge = CG_Data(:,8);
CG_Heavy_Discharge = CG_Discharge(Heavy_Days);
CG_Medium_Discharge = CG_Discharge(Medium_Days);

% Total Discharge over 2018-2019:
%CG_Total_Discharge = sum(CG_Discharge);

% Best Fit Regression Line: 
CG_Coeff_Heavy = polyfit(Heavy_GSat,CG_Heavy_Discharge,1);
CG_Coeff_Medium = polyfit(Medium_GSat, CG_Medium_Discharge,1);


% Highland 2018-2019
% Load Data into matrix form.
HL_Data = xlsread('Pump_Station_Flow.xlsx',5,'B2:J731');
HL_Discharge = HL_Data(:,7);
HL_Heavy_Discharge = HL_Discharge(Heavy_Days);
HL_Medium_Discharge = HL_Discharge(Medium_Days);
HL_Precip = HL_Data(:,8);
il = 1;
jl = 1;


for m = 2.0:-.01:0.5
    m;
    for n = 0:15
        n;
        %Extra = zeros(n,1);
        Heavy_Days2 = find(HL_Precip(1:end-n) > m)
        Heavy_Days_Delay = Heavy_Days2 + n;
        Heavy_GSat2 = HL_Precip(Heavy_Days2);
        HL_Heavy_Discharge2 = HL_Discharge(Heavy_Days_Delay); 
        HL_Coeff_Heavy2 = polyfit(Heavy_GSat2,HL_Heavy_Discharge2,1);
        HL_Fit_Heavy2 = polyval(HL_Coeff_Heavy2, Heavy_GSat2);
        A = corrcoef(HL_Heavy_Discharge2, HL_Fit_Heavy2).^2
        
        Rsq(il,jl) = A(1,2);
        il = il+1;
        
    end;
        il = 1;
        jl = jl+1;
end;

[M,N] = meshgrid(2.0:-.05:1.0,0:15);
surf(Rsq)

% Total Discharge over 2018-2019:
%HL_Total_Discharge = sum(HL_Discharge);

% Best Fit Regression Line: 
HL_Coeff_Heavy = polyfit(Heavy_GSat,HL_Heavy_Discharge,1);
HL_Coeff_Medium = polyfit(Medium_GSat, HL_Medium_Discharge,1);

% Hilltop 2019
% Load Data into matrix form.
HT_Data = xlsread('Pump_Station_Flow.xlsx',9,'B2:K731');

% Finding the nans of of each vector: 
% ind_D = find(isnan(HT_Discharge));
% ind_P = find(isnan(HT_Precip)); 
% ind   = [ind_D; ind_P];
% x     = 1:length(HT_Discharge);
% x(ind) = [];

% Total Discharge over 2018-2019:
%HT_Total_Discharge = sum(HT_Discharge(x));

% Best Fit Regression Line: 
%HT_Coeff = polyfit(HT_Precip(x),HT_Discharge(x),1);


% Create linear fit and find R^2
BC_Fit_Heavy = polyval(BC_Coeff_Heavy, Heavy_GSat);
BC_Fit_Medium = polyval(BC_Coeff_Medium, Medium_GSat);

CG_Fit_Heavy = polyval(CG_Coeff_Heavy, Heavy_GSat);
CG_Fit_Medium = polyval(CG_Coeff_Medium, Medium_GSat);

HL_Fit_Heavy = polyval(HL_Coeff_Heavy, Heavy_GSat);
HL_Fit_Medium = polyval(HL_Coeff_Medium, Medium_GSat);

% HT_Fit = polyval(HT_Coeff, HT_Precip);
% Briar Cliff
BC_Rsq_Heavy = 1 - sum((BC_Heavy_Discharge - BC_Fit_Heavy).^2) / ...
    sum((BC_Heavy_Discharge - mean(BC_Heavy_Discharge)).^2);

corrcoef(BC_Heavy_Discharge, BC_Fit_Heavy).^2;

BC_Rsq_Medium = 1 - sum((BC_Medium_Discharge - BC_Fit_Medium).^2) / ...
    sum((BC_Medium_Discharge - mean(BC_Medium_Discharge)).^2);

corrcoef(BC_Medium_Discharge, BC_Fit_Medium).^2;

% College Gardens
CG_Rsq_Heavy = 1 - sum((CG_Heavy_Discharge - CG_Fit_Heavy).^2) / ...
    sum((CG_Heavy_Discharge - mean(CG_Heavy_Discharge)).^2);

corrcoef(CG_Heavy_Discharge, CG_Fit_Heavy).^2;

CG_Rsq_Medium = 1 - sum((CG_Medium_Discharge - CG_Fit_Medium).^2) / ...
    sum((CG_Medium_Discharge - mean(CG_Medium_Discharge)).^2);

corrcoef(CG_Medium_Discharge, CG_Fit_Medium).^2;

% Highland
HL_Rsq_Heavy = 1 - sum((HL_Heavy_Discharge - HL_Fit_Heavy).^2) / ...
    sum((HL_Heavy_Discharge - mean(HL_Heavy_Discharge)).^2);

corrcoef(HL_Heavy_Discharge, HL_Fit_Heavy).^2;

HL_Rsq_Medium = 1 - sum((HL_Medium_Discharge - HL_Fit_Medium).^2) / ...
    sum((HL_Medium_Discharge - mean(HL_Medium_Discharge)).^2);

corrcoef(HL_Medium_Discharge, HL_Fit_Medium).^2;



% figure(1)
% subplot(2,1,1)
% plot(BC_Heavy_Discharge)
% title('Briar Cliff Discharge', 'fontsize', 16)
% subplot(2,1,2)
% plot(Heavy_GSat)
% title('Saturation (Heavy)', 'fontsize', 16)

% figure(2)
% subplot(2,1,1)
% plot(BC_Medium_Discharge)
% title('Briar Cliff Discharge', 'fontsize', 16)
% subplot(2,1,2)
% plot(Medium_GSat)
% title('Saturation (Medium)', 'fontsize', 16)
% 
% 
% figure(3)
% subplot(2,1,1)
% plot(CG_Heavy_Discharge)
% title('College Gardens Discharge', 'fontsize', 16)
% subplot(2,1,2)
% plot(Heavy_GSat)
% title('Ground Saturation (Heavy)', 'fontsize', 16)
% 
% figure(4)
% subplot(2,1,1)
% plot(CG_Medium_Discharge)
% title('College Gardens Discharge', 'fontsize', 16)
% subplot(2,1,2)
% plot(Medium_GSat)
% title('Ground Saturation (Medium)', 'fontsize', 16)
% 
% 
% figure(5)
% subplot(2,1,1)
% plot(HL_Heavy_Discharge)
% title('Highland Discharge', 'fontsize', 16)
% subplot(2,1,2)
% plot(Heavy_GSat)
% title('Ground Saturation (Heavy)', 'fontsize', 16)
% 
% figure(6)
% subplot(2,1,1)
% plot(HL_Medium_Discharge)
% title('Highland Discharge', 'fontsize', 16)
% subplot(2,1,2)
% plot(Medium_GSat)
% title('Ground Saturation (Medium)', 'fontsize', 16)


% Discharge vs Ground Saturation
% figure(4)
% subplot(2,2,1)
% plot(Ground_Sat_Data, BC_Discharge,'ko','linewidth',5)
% hold on
% plot(Ground_Sat_Data,BC_GSat_Fit,'b-','linewidth',2)
% title('Scatterplot of Discharge vs. Ground Saturation: Briar Cliff','fontsize',18,'interpreter','latex')
% xlabel('Ground Saturation (inches)','fontsize',18,'interpreter','latex')
% ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
% grid on
% grid minor
% subplot(2,2,2)
% plot(Ground_Sat_Data, CG_Discharge,'ko','linewidth',5)
% hold on
% plot(Ground_Sat_Data,CG_GSat_Fit,'b-','linewidth',2)
% title('Scatterplot of Discharge vs. Ground Saturation: College Gardens','fontsize',18,'interpreter','latex')
% xlabel('Ground Saturation (inches)','fontsize',18,'interpreter','latex')
% ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
% grid on
% grid minor
% subplot(2,2,3)
% plot(Ground_Sat_Data, HL_Discharge,'ko','linewidth',5)
% hold on
% plot(Ground_Sat_Data, HL_GSat_Fit,'b-','linewidth',2)
% title('Scatterplot of Discharge vs. Ground Saturation: Highland','fontsize',18,'interpreter','latex')
% xlabel('Ground Saturation (inches)','fontsize',18,'interpreter','latex')
% ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
% grid on
% grid minor
% subplot(2,2,4)
% plot(HT_GSat_Data(x), HT_Discharge(x),'ko','linewidth',5)
% hold on
% plot(HT_GSat_Data(x), HT_GSat_Fit,'b-','linewidth',2)
% title('Scatterplot of Discharge vs. Ground Saturation: Hilltop','fontsize',18,'interpreter','latex')
% xlabel('Ground Saturation (inches)','fontsize',18,'interpreter','latex')
% ylabel('Daily Discharge','fontsize',18,'interpreter','latex')
% grid on
% grid minor
% % fig = gfc;
% % exportgraphics(fig, 'scatterplots_18_19_2.png', 'Resolution', 300)
