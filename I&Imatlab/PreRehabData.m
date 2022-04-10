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
                    'Sheet','Hilltop','Range','B2:K762');
                

Pre_Precip = readmatrix('Pre_PS_Stations_by_Sheet.xlsx',...
                    'Sheet','Precipitation','Range','A2:G762');
                        
                
BC_Precip = Pre_Precip(:, 6);
BC_GSat = Pre_Precip(:, 7);
BC_Discharge = BC_Pre(:, 10);

% Coefficients and R^2 for Precipitation vs Pump Discharge
BC_Precip_Coeff = polyfit(BC_Precip, BC_Discharge, 1)
BC_Precip_Fit = polyval(BC_Precip_Coeff, BC_Precip);

BC_Precip_Rsq = 1 - sum((BC_Discharge - BC_Precip_Fit).^2) / ...
    sum((BC_Discharge - mean(BC_Discharge)).^2)

corrcoef(BC_Discharge, BC_Precip_Fit).^2

% Coefficients and R^2 for Groound Saturation vs Pump Discharge
BC_GSat_Coeff = polyfit(BC_GSat, BC_Discharge, 1)
BC_GSat_Fit = polyval(BC_GSat_Coeff, BC_GSat);

BC_GSat_Rsq = 1 - sum((BC_Discharge - BC_GSat_Fit).^2) / ...
    sum((BC_Discharge - mean(BC_Discharge)).^2)

corrcoef(BC_Discharge, BC_GSat_Fit).^2
