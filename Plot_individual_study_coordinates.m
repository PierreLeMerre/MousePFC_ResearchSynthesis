%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to plot the location  of the mean PFC coordinates of each publication included in the research-synthesis.
% Requires access to the Allen Data
% Download it form here: http://download.alleninstitute.org/informatics-archive/current-release/mouse_ccf/
% Requires the following companion functions:
%
%   - npy-matlab repository (Github)
%   - get_Allen_Data.m (https://github.com/cortex-lab/allenCCF)
%   - allenCCFbregma.m (https://github.com/cortex-lab/allenCCF)
%   - allen_ccf_colormap.m (https://github.com/cortex-lab/allenCCF)
%   - inpolyhedron.m (Copyright (c) 2015, Sven)
%   - hex2rgb.m
%   - AddOneAllenStruct.m 
%   - plotMLSlice.m
%   - plotAPSlice.m
%
% Written by Pierre Le Merre
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; 
clear;
close all;
clc;
set(0, 'DefaultFigureRenderer', 'painters')

%% Get Allen Data
[av,st,tv]=get_Allen_Data();

%% Get Bregma
bregma = allenCCFbregma;
bregma=[bregma(1) bregma(3) bregma(2)];

%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%    Workbook: /Users/pierre/Documents/Github/Table1-Database.xlsx
%    Worksheet: Table1-Database
% Setup the Import Options and import the data

opts = spreadsheetImportOptions("NumVariables", 24);

% Specify sheet and range
opts.Sheet = "Table1-Database";
opts.DataRange = "A2:X101";

% Specify column names and types
opts.VariableNames = ["Year", "RefShort", "AreaName", "InactivationMethod", "AP", "ML", "DV", "DVorigin", "MeanAP", "MeanML", "MeanDV", "CorrectedDV", "BrainSurfaceDVCorr", "Complexityindex", "SensoryModality", "Tasktype", "inMOs", "inACA", "inPL", "inILA", "inORBm", "inORBvl", "inORBl", "AllenAtlasAnnotation2017"];
opts.VariableTypes = ["double", "string", "categorical", "categorical", "double", "double", "double", "categorical", "double", "double", "double", "double", "double", "double", "double", "double", "categorical", "categorical", "categorical", "categorical", "categorical", "categorical", "categorical", "categorical"];

% Specify variable properties
opts = setvaropts(opts, "RefShort", "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["RefShort", "AreaName", "InactivationMethod", "DVorigin", "inMOs", "inACA", "inPL", "inILA", "inORBm", "inORBvl", "inORBl", "AllenAtlasAnnotation2017"], "EmptyFieldRule", "auto");

% Import the data
T = readtable("/Users/pierre/Documents/Github/Table1-Database.xlsx", opts, "UseExcel", false);


%% Clear temporary variables
clear opts

MM.AP = T.MeanAP.*100;
MM.ML = T.MeanML.*100;
MM.DV = T.CorrectedDV.*100;
label = T.AllenAtlasAnnotation2017;
Ref = T.RefShort;

for i = 1:numel(MM.AP)
    
AP = MM.AP(i);
DV = MM.DV(i);
ML = MM.ML(i);
L = label(i);
R = T.RefShort(i);

figure;
[cor]= plotAPSlice(bregma(1)-AP,av,tv,st); 
imagesc(cor);
set(gca,'dataaspectratio',[1 1 1])
cmap = flipud(gray);
colormap(cmap)
hold on
plot(bregma(2)+ML,(bregma(3)+DV),'ro')
set(gca,'XTick',[70 170 270 370 470 570 670 770 870 970 1070]);
set(gca,'XTickLabel',[-5 -4 -3 -2 -1 0 1 2 3 4 5]);
xlabel('ML (mm)')
set(gca,'YTick',[65 165 265 365 465 565 665 765]);
set(gca,'YTickLabel',[0 -1 -2 -3 -4 -5 -6 -7]);
ylabel('DV (mm)')
title([char(R) ': ' char(L) ' , AP: ' num2str(AP/100) ' mm, ML: ' num2str(ML/100) ' mm, DV: ' num2str(DV/100) ' mm'])
%saveas(gcf,['/Users/pierre/Documents/Github/MousePFC_ResearchSynthesis/AllenAtlasLocationCCFv3_individualstudies/' char(R) '.png'])
%close()                

end