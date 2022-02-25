% Machine Learning -- Decision Tree: 
clear all, close all, clc

% Load in Briar Cliff: 
BC_Data_20_21;

% Predictor Variables: 
ind = find(isnan(BC_Ground_Sat)==0);
X1 = BC_Precip(ind);
X2 = BC_Ground_Sat(ind);

X = [X1 X2];

% Response Varible: 
Y  = BC_Discharge(ind);

% Build a Decision Tree: 
Vars = {'P','GS'};

% Generate Tree: 
Tree = fitrtree(X,Y,'PredictorNames',Vars,'CategoricalPredictors',[],'Prune','on');            
% Tree_3 = prune(Tree_3,'level',Tree_3.PruneList(1)-5);

view(Tree,'mode','graph')

% Make a prediction: 
predict(Tree,[.04 1.2])
