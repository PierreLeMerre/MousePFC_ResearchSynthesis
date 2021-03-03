%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to reproduce panels E, F and G from Figure 3.
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
%% Parameters

% colormaps
Complexity = {'#F5C9B6','#F5C9B6','#EE967A','#EE967A','#C63434','#C63434','#7E2321','#7E2321','#0F0505','#0F0505'};
Modality = {'#56C596','#5992F7','#E7AD66','#E9F416','#FFFFFF','#CE5A60'};
Task = {'#9E2E83','#568C56','#F98B06'};

Subregions = {'MOs','ACA','PL','ILA','ORBm','ORBvl','ORBl'};
Subdivisions = {'dmPFC','vmPFC','vlPFC'};

%% Get Allen Data
[av,st,tv]=get_Allen_Data();

%% Get Bregma
bregma = allenCCFbregma;
bregma=[bregma(1) bregma(3) bregma(2)];

%% load mouse meta database
% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
% Workbook: /Users/pierre/Google Drive/PFC-Review-REVISED-2/Meta-analysis/Table1-Database.xlsx
% Worksheet: Table1-Database
% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 25);
% Specify sheet and range
opts.Sheet = "Table1-Database";
opts.DataRange = "A2:Y101";
% Specify column names and types
opts.VariableNames = ["Year", "RefShort", "AreaName", "InactivationMethod", "AP", "ML", "DV", "DVorigin", "MeanAP", "MeanML", "MeanDV", "CorrectedDV", "BrainSurfaceDVCorr", "AllenAtlastiltDVCorr", "Complexityindex", "SensoryModality", "Tasktype", "inMOs", "inACA", "inPL", "inILA", "inORBm", "inORBvl", "inORBl", "AllenAtlasAnnotation2017"];
opts.VariableTypes = ["double", "string", "categorical", "categorical", "double", "double", "double", "categorical", "double", "double", "double", "double", "double", "double", "double", "double", "double", "categorical", "categorical", "categorical", "categorical", "categorical", "categorical", "categorical", "categorical"];
% Specify variable properties
opts = setvaropts(opts, "RefShort", "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["RefShort", "AreaName", "InactivationMethod", "DVorigin", "inMOs", "inACA", "inPL", "inILA", "inORBm", "inORBvl", "inORBl", "AllenAtlasAnnotation2017"], "EmptyFieldRule", "auto");
% Import the data
T = readtable("/Users/pierre/Google Drive/PFC-Review-REVISED-2/Meta-analysis/Table1-Database.xlsx", opts, "UseExcel", false);


%% Clear temporary variables
clear opts

MM.AP = T.MeanAP.*100;
MM.ML = T.MeanML.*100;
MM.DV = T.CorrectedDV.*100;
MM.Cplx = T.Complexityindex;
MM.Sens = T.SensoryModality;
MM.Task = T.Tasktype;

%% Allen Structutres
slice_spacing=10;

% MOs
structure3d_3=AddOneAllenStruct([25 26 27 28 29],av,[1 0 0]);
%Offset the vertices with bregma to put bregma to [0 0 0].
if ~isempty(structure3d_3)
    structure3d_3.vertices(:,1)=(structure3d_3.vertices(:,1)-bregma(1)./10).*slice_spacing;
    structure3d_3.vertices(:,2)=(structure3d_3.vertices(:,2)-bregma(2)./10).*slice_spacing;
    structure3d_3.vertices(:,3)=-(structure3d_3.vertices(:,3)-bregma(3)./10).*slice_spacing;
end


% ACA
structure3d_0=AddOneAllenStruct([227 228 229 230 231 233 234 235 236 237],av,[1 1 0]); %ACC
%Offset the vertices with bregma to put bregma to [0 0 0].
if ~isempty(structure3d_0)
    structure3d_0.vertices(:,1)=(structure3d_0.vertices(:,1)-bregma(1)./10).*slice_spacing;
    structure3d_0.vertices(:,2)=(structure3d_0.vertices(:,2)-bregma(2)./10).*slice_spacing;
    structure3d_0.vertices(:,3)=-(structure3d_0.vertices(:,3)-bregma(3)./10).*slice_spacing;
end


% PL
structure3d_1=AddOneAllenStruct([239 240 241 242 243 244],av,[1 0.5 0]);
%Offset the vertices with bregma to put bregma to [0 0 0].
if ~isempty(structure3d_1)
    structure3d_1.vertices(:,1)=(structure3d_1.vertices(:,1)-bregma(1)./10).*slice_spacing;
    structure3d_1.vertices(:,2)=(structure3d_1.vertices(:,2)-bregma(2)./10).*slice_spacing;
    structure3d_1.vertices(:,3)=-(structure3d_1.vertices(:,3)-bregma(3)./10).*slice_spacing;
end


% ILA
structure3d_2=AddOneAllenStruct([246 247 248 249 250 251 252],av,[1 0 0]);
%Offset the vertices with bregma to put bregma to [0 0 0].
if ~isempty(structure3d_2)
    structure3d_2.vertices(:,1)=(structure3d_2.vertices(:,1)-bregma(1)./10).*slice_spacing;
    structure3d_2.vertices(:,2)=(structure3d_2.vertices(:,2)-bregma(2)./10).*slice_spacing;
    structure3d_2.vertices(:,3)=-(structure3d_2.vertices(:,3)-bregma(3)./10).*slice_spacing;
end


% ROBm
structure3d_4=AddOneAllenStruct([266 267 268 269 270 271 272],av,[1 0 0]);
%Offset the vertices with bregma to put bregma to [0 0 0].
if ~isempty(structure3d_4)
    structure3d_4.vertices(:,1)=(structure3d_4.vertices(:,1)-bregma(1)./10).*slice_spacing;
    structure3d_4.vertices(:,2)=(structure3d_4.vertices(:,2)-bregma(2)./10).*slice_spacing;
    structure3d_4.vertices(:,3)=-(structure3d_4.vertices(:,3)-bregma(3)./10).*slice_spacing;
end


% ORBl
structure3d_5=AddOneAllenStruct([260 261 262 263 264],av,[1 0 0]);
%Offset the vertices with bregma to put bregma to [0 0 0].
if ~isempty(structure3d_5)
    structure3d_5.vertices(:,1)=(structure3d_5.vertices(:,1)-bregma(1)./10).*slice_spacing;
    structure3d_5.vertices(:,2)=(structure3d_5.vertices(:,2)-bregma(2)./10).*slice_spacing;
    structure3d_5.vertices(:,3)=-(structure3d_5.vertices(:,3)-bregma(3)./10).*slice_spacing;
end

% ORBvl
structure3d_6=AddOneAllenStruct([274 275 276 277 278],av,[1 0 0]);
%Offset the vertices with bregma to put bregma to [0 0 0].
if ~isempty(structure3d_6)
    structure3d_6.vertices(:,1)=(structure3d_6.vertices(:,1)-bregma(1)./10).*slice_spacing;
    structure3d_6.vertices(:,2)=(structure3d_6.vertices(:,2)-bregma(2)./10).*slice_spacing;
    structure3d_6.vertices(:,3)=-(structure3d_6.vertices(:,3)-bregma(3)./10).*slice_spacing;
end

%% Assign the points in polyhedrons

in_MOs=inpolyhedron(structure3d_3,[squeeze(-MM.AP) squeeze(-MM.ML) squeeze(-MM.DV)]);
in_ACA=inpolyhedron(structure3d_0,[squeeze(-MM.AP) squeeze(-MM.ML) squeeze(-MM.DV)]);
in_PL=inpolyhedron(structure3d_1,[squeeze(-MM.AP) squeeze(-MM.ML) squeeze(-MM.DV)]);
in_ILA=inpolyhedron(structure3d_2,[squeeze(-MM.AP) squeeze(-MM.ML) squeeze(-MM.DV)]);
in_ORBm=inpolyhedron(structure3d_4,[squeeze(-MM.AP) squeeze(-MM.ML) squeeze(-MM.DV)]);
in_ORBvl=inpolyhedron(structure3d_5,[squeeze(-MM.AP) squeeze(-MM.ML) squeeze(-MM.DV)]);
in_ORBl=inpolyhedron(structure3d_6,[squeeze(-MM.AP) squeeze(-MM.ML) squeeze(-MM.DV)]);
in = [in_MOs in_ACA in_PL in_ILA in_ORBm in_ORBl in_ORBvl];

% remove double detected structures, only first one counts
for i = 1 : size(in,1)
    if sum(in(i,:))>1
       ii = find(in(i,:),1);
       in(i,ii+1) = false;
    end
    if i==47
    in(i,5) = false;    
    end
end

%% Complexity index
colors_brain1=hex2rgb(Complexity);
ML=0.3;
AP=1.95;
win_sz=25;

figure;
% sagital
ax1=subplot(6,7,1);
[sag] = plotMLSlice(bregma(2)+ML*100,av,tv,st); 
imagesc(sag)
set(gca,'dataaspectratio',[1 1 1])
cmap = flipud(gray);
colormap(cmap)
hold on
hold on
for i=1:numel(MM.AP)
  plot(bregma(1)-MM.AP(i),bregma(3)+MM.DV(i),'Marker','o','MarkerSize',10,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',colors_brain1(MM.Cplx(i),:))
end

%Add diamonds as means
l = MM.Cplx;
low = 0;
up = 3; 
mean_cplx_ap = [];
mean_cplx_ml = [];
mean_cplx_dv = []; 
for i=1:5
cplx_indices=(low<l & l<up);
mean_cplx_ap(i) = nanmean(MM.AP(cplx_indices));
mean_cplx_ml(i) = nanmean(MM.ML(cplx_indices));
mean_cplx_dv(i) = nanmean(MM.DV(cplx_indices));
plot(bregma(1)-mean_cplx_ap(i),bregma(3)+mean_cplx_dv(i),'Marker','diamond','MarkerSize',20,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',colors_brain1(low + 1,:))
low = low + 2;
up = up + 2;
end


set(gca,'XTick',[40 140 240 340 440 540 640 740 840 940 1040 1140 1240 1340]);
set(gca,'XTickLabel',[-5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8]);
xlabel('AP (mm)')
set(gca,'YTick',[65 165 265 365 465 565 665 765]);
set(gca,'YTickLabel',[0 -1 -2 -3 -4 -5 -6 -7]);
ylabel('DV (mm)')
title(['Complexity Index, Sagital Projection at ' num2str(ML) ' mm'])
ax2=subplot(6,7,2);
x=nan(1,size(av,1));
for i=1:size(av,1)
  temp_i=find((round(bregma(1)-MM.AP))==i);
  if numel(temp_i)==1
    x(i)=MM.Cplx(temp_i);
  elseif numel(temp_i)>1
    x(i)=mean(MM.Cplx(temp_i));
  end
end
in=1;
out=win_sz;
step=1;
win_nb=(size(av,1)-out)/step;
win_centers=linspace(1,size(av,1)-out,win_nb);
s=zeros(1,win_nb);
for i=1:(win_nb-1)
  t=nanmean(x(in:out));
  if ~isnan(t)
    s(i)=t;
  end
  in=in+step;
  out=out+step;
end
g=gausswin(win_sz);
g2=g./trapz(g);
gk=conv(s,g2,'same');
gk=[zeros(1,win_sz) gk];
area(1:size(av,1),gk,'Facecolor','r')
xlim([0 size(av,1)])
ylim([0 10])
set(gca,'XTick',[40 140 240 340 440 540 640 740 840 940 1040 1140 1240 1340]);
set(gca,'XTickLabel',[-5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8]);
xlabel('AP (mm)')
ylabel('Comp. Index')
title(['Smoothing window: ' num2str(win_sz) ' um'])
%set(ax1, 'position',[0.15 , 0.15, 0.7, 0.10]);
%set(gcf,'units','points','position',[700,1000,1140*2/3,800*2/3])
% coronal
ax7=subplot(6,7,7);
[cor]= plotAPSlice(bregma(1)-AP*100,av,tv,st); 
imagesc(cor);
set(gca,'dataaspectratio',[1 1 1])
cmap = flipud(gray);
colormap(cmap)
hold on
hold on
for i=1:numel(MM.AP)
  plot(bregma(2)+MM.ML(i),bregma(3)+MM.DV(i),'Marker','o','MarkerSize',10,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',colors_brain1(MM.Cplx(i),:))
end

%Add diamonds as means
l = MM.Cplx;
low = 0;
up = 3;
for i=1:5
cplx_indices=(low<l & l<up);
plot(bregma(2)+mean_cplx_ml(i),bregma(3)+mean_cplx_dv(i),'Marker','diamond','MarkerSize',20,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',colors_brain1(low + 1,:))
low = low + 2;
up = up + 2;
end

set(gca,'XTick',[70 170 270 370 470 570 670 770 870 970 1070]);
set(gca,'XTickLabel',[-5 -4 -3 -2 -1 0 1 2 3 4 5]);
xlabel('ML (mm)')
set(gca,'YTick',[65 165 265 365 465 565 665 765]);
set(gca,'YTickLabel',[0 -1 -2 -3 -4 -5 -6 -7]);
ylabel('DV (mm)')
title(['Complexity Index, Coronal Projection at ' num2str(AP) ' mm'])
% Spatial smoothing DV
x=nan(1,size(av,2));
for i=1:size(av,2)
  temp_i=find((round(bregma(3)+MM.DV))==i);
  if numel(temp_i)==1
    x(i)=MM.Cplx(temp_i);
  elseif numel(temp_i)>1
    x(i)=mean(MM.Cplx(temp_i));
  end
end
in=1;
out=win_sz;
step=1;
win_nb=(size(av,2)-out)/step;
win_centers=linspace(1,size(av,2)-out,win_nb);
s=zeros(1,win_nb);
for i=1:(win_nb-1)
  t=nanmean(x(in:out));
  if ~isnan(t)
    s(i)=t;
  end
  in=in+step;
  out=out+step;
end
g=gausswin(win_sz);
g2=g./trapz(g);
gk=conv(s,g2,'same');
gk=[zeros(1,win_sz) gk];
% Spatial smoothing ML
x=nan(1,size(av,3));
for i=1:size(av,3)
  temp_i=find((round(bregma(2)+MM.ML))==i);
  if numel(temp_i)==1
    x(i)=MM.Cplx(temp_i);
  elseif numel(temp_i)>1
    x(i)=mean(MM.Cplx(temp_i));
  end
end
in=1;
out=win_sz;
step=1;
win_nb=(size(av,3)-out)/step;
win_centers=linspace(1,size(av,3)-out,win_nb);
s=zeros(1,win_nb);
for i=1:(win_nb-1)
  t=nanmean(x(in:out));
  if ~isnan(t)
    s(i)=t;
  end
  in=in+step;
  out=out+step;
end
g=gausswin(win_sz);
g2=g./trapz(g);
gk_ml=conv(s,g2,'same');
gk_ml=[zeros(1,win_sz) gk_ml];
ax13=subplot(6,7,13);
area(1:size(av,2),gk,'Facecolor','r')
set(gca,'XTick',[65 165 265 365 465 565 665 765]);
set(gca,'XTickLabel',[0 -1 -2 -3 -4 -5 -6 -7]);
xlabel('DV (mm)')
set(gca, 'XDir','reverse')
xlim([0 size(av,2)])
ylim([0 10])
view([90 -90])
title(['Smoothing window: ' num2str(win_sz) ' um'])
ax8=subplot(6,7,8);
area(1:size(av,3),gk_ml,'Facecolor','r')
set(gca,'XTick',[70 170 270 370 470 570 670 770 870 970 1070]);
set(gca,'XTickLabel',[-5 -4 -3 -2 -1 0 1 2 3 4 5]);
xlabel('ML (mm)')
xlim([0 size(av,3)])
ylim([0 10])
title(['Smoothing window: ' num2str(win_sz) ' um'])

% Sagital plot
set(ax1, 'position',[0.025, 0.65, 0.45, 0.3]);
set(ax2, 'position',[0.025 , 0.55, 0.45, 0.07]);
%coronal
set(ax7, 'position',[0.49 , 0.65, 0.35, 0.3]);
set(ax8, 'position',[0.49 , 0.55, 0.35, 0.07]);
set(ax13, 'position',[0.85, 0.65, 0.07, 0.3]);

set(gcf,'units','points','position',[700,1000,1320,1150])

%% Sensory Modality
colors_brain2=hex2rgb(Modality);
win_sz=25;
AP=1.95;

figure;

ax7=subplot(6,7,7);
[corr]= plotAPSlice(bregma(1)-AP*100,av,tv,st); 
imagesc(corr)
set(gca,'dataaspectratio',[1 1 1])
cmap = flipud(gray);
colormap(cmap)
hold on
for i=1:numel(MM.AP)
    plot(bregma(2)+MM.ML(i),bregma(3)+MM.DV(i),'Marker','o','MarkerSize',10,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',colors_brain2(MM.Sens(i),:))
end
set(gca,'XTick',[70 170 270 370 470 570 670 770 870 970 1070]);
set(gca,'XTickLabel',[-5 -4 -3 -2 -1 0 1 2 3 4 5]);
xlabel('ML (mm)')
set(gca,'YTick',[65 165 265 365 465 565 665 765]);
set(gca,'YTickLabel',[0 -1 -2 -3 -4 -5 -6 -7]);
set(gca,'YTickLabel',{' '})
%ylabel('DV (mm)')
title(['Sensory Modality, Coronal Projection at ' num2str(AP) ' mm'])

% Spatial smoothing DV
mm2=round(MM.DV);
x1=nan(1,size(av,2)); x2=nan(1,size(av,2)); x3=nan(1,size(av,2));
x4=nan(1,size(av,2)); x5=nan(1,size(av,2)); x6=nan(1,size(av,2));


for i=1:size(av,2)
    
    temp_i=find((mm2+bregma(3))==i);
    
    if numel(temp_i)==1
        
        if MM.Sens(temp_i)==1
            x1(i)=1;
        end
        if MM.Sens(temp_i)==2
            x2(i)=1;
        end
        if MM.Sens(temp_i)==3
            x3(i)=1;
        end
        if MM.Sens(temp_i)==4
            x4(i)=1;
        end
        if MM.Sens(temp_i)==5
            x5(i)=1;
        end
        if MM.Sens(temp_i)==6
            x6(i)=1;
        end
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==1)
        x1(i)=numel(find(MM.Sens(temp_i)==1));
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==2)
        x2(i)=numel(find(MM.Sens(temp_i)==2));
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==3)
        x3(i)=numel(find(MM.Sens(temp_i)==3));
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==4)
        x4(i)=numel(find(MM.Sens(temp_i)==4));
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==5)
        x5(i)=numel(find(MM.Sens(temp_i)==5));
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==6)
        x6(i)=numel(find(MM.Sens(temp_i)==6));
    end
    
end

in=1;
out=win_sz;
step=1;
win_nb=(size(av,2)-out)/step;
win_centers=linspace(1,size(av,2)-out,win_nb);
s1=zeros(1,win_nb); s2=zeros(1,win_nb); s3=zeros(1,win_nb);
s4=zeros(1,win_nb); s5=zeros(1,win_nb); s6=zeros(1,win_nb);

for i=1:(win_nb)
    t1=nanmean(x1(in:out)); t2=nanmean(x2(in:out)); t3=nanmean(x3(in:out));
    t4=nanmean(x4(in:out)); t5=nanmean(x5(in:out)); t6=nanmean(x6(in:out));
    
    if ~isnan(t1)
        s1(i)=t1;
    end
    if ~isnan(t2)
        s2(i)=t2;
    end
    if ~isnan(t3)
        s3(i)=t3;
    end
    if ~isnan(t4)
        s4(i)=t4;
    end
    if ~isnan(t5)
        s5(i)=t5;
    end
    if ~isnan(t6)
        s6(i)=t6;
    end
    in=in+step;
    out=out+step;
end



g=gausswin(win_sz);
g2=g./trapz(g);

gk1=conv(s1,g2,'same'); gk2=conv(s2,g2,'same'); gk3=conv(s3,g2,'same');
gk4=conv(s4,g2,'same'); gk5=conv(s5,g2,'same'); gk6=conv(s6,g2,'same');

gk1=[zeros(1,win_sz) gk1]; gk2=[zeros(1,win_sz) gk2]; gk3=[zeros(1,win_sz) gk3];
gk4=[zeros(1,win_sz) gk4]; gk5=[zeros(1,win_sz) gk5]; gk6=[zeros(1,win_sz) gk6];


% Spatial smoothing ML
mm2=round(MM.ML);
x1=nan(1,size(av,3)); x2=nan(1,size(av,3)); x3=nan(1,size(av,3));
x4=nan(1,size(av,3)); x5=nan(1,size(av,3)); x6=nan(1,size(av,3));


for i=1:size(av,3)
    
    temp_i=find((mm2+bregma(2))==i);
    
    if numel(temp_i)==1
        
        if MM.Sens(temp_i)==1
            x1(i)=1;
        end
        if MM.Sens(temp_i)==2
            x2(i)=1;
        end
        if MM.Sens(temp_i)==3
            x3(i)=1;
        end
        if MM.Sens(temp_i)==4
            x4(i)=1;
        end
        if MM.Sens(temp_i)==5
            x5(i)=1;
        end
        if MM.Sens(temp_i)==6
            x6(i)=1;
        end
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==1)
        x1(i)=numel(find(MM.Sens(temp_i)==1));
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==2)
        x2(i)=numel(find(MM.Sens(temp_i)==2));
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==3)
        x3(i)=numel(find(MM.Sens(temp_i)==3));
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==4)
        x4(i)=numel(find(MM.Sens(temp_i)==4));
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==5)
        x5(i)=numel(find(MM.Sens(temp_i)==5));
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==6)
        x6(i)=numel(find(MM.Sens(temp_i)==6));
    end
    
end

in=1;
out=win_sz;
step=1;
win_nb=(size(av,3)-out)/step;
win_centers=linspace(1,size(av,3)-out,win_nb);
s1=zeros(1,win_nb); s2=zeros(1,win_nb); s3=zeros(1,win_nb);
s4=zeros(1,win_nb); s5=zeros(1,win_nb); s6=zeros(1,win_nb);

for i=1:(win_nb)
    t1=nanmean(x1(in:out)); t2=nanmean(x2(in:out)); t3=nanmean(x3(in:out));
    t4=nanmean(x4(in:out)); t5=nanmean(x5(in:out)); t6=nanmean(x6(in:out));
    
    if ~isnan(t1)
        s1(i)=t1;
    end
    if ~isnan(t2)
        s2(i)=t2;
    end
    if ~isnan(t3)
        s3(i)=t3;
    end
    if ~isnan(t4)
        s4(i)=t4;
    end
    if ~isnan(t5)
        s5(i)=t5;
    end
    if ~isnan(t6)
        s6(i)=t6;
    end
    in=in+step;
    out=out+step;
end



g=gausswin(win_sz);
g2=g./trapz(g);

gk1_ml=conv(s1,g2,'same'); gk2_ml=conv(s2,g2,'same'); gk3_ml=conv(s3,g2,'same');
gk4_ml=conv(s4,g2,'same'); gk5_ml=conv(s5,g2,'same'); gk6_ml=conv(s6,g2,'same');

gk1_ml=[zeros(1,win_sz) gk1_ml]; gk2_ml=[zeros(1,win_sz) gk2_ml]; gk3_ml=[zeros(1,win_sz) gk3_ml];
gk4_ml=[zeros(1,win_sz) gk4_ml]; gk5_ml=[zeros(1,win_sz) gk5_ml]; gk6_ml=[zeros(1,win_sz) gk6_ml];



for k=1:6
    eval(['cumtrap_gk' num2str(k) '=[];'])
    eval(['cumtrap_gk' num2str(k) '_ml=[];'])
    if k~=5
        for i=1:size(gk1,2)
            eval([' cumtrap_gk' num2str(k) '(i)=trapz(gk' num2str(k) '(1:i));'])
        end
        eval(['mDV' num2str(k) '=find(cumtrap_gk' num2str(k) '>=ceil(trapz(gk' num2str(k) ')/2),1,' '''first''' ');'])
        
        for i=1:size(gk1_ml,2)
            eval(['cumtrap_gk' num2str(k) '_ml(i)=trapz(gk' num2str(k) '_ml(1:i));'])
        end
        eval(['mML' num2str(k) '=find(cumtrap_gk' num2str(k) '_ml>=ceil(trapz(gk' num2str(k) '_ml)/2),1,' '''first''' ');'])
        
        eval(['plot(mML' num2str(k) ',mDV' num2str(k) ',''Marker'',''diamond'',''MarkerSize'',20,''MarkerEdgeColor'',[0 0 0],''MarkerFaceColor'',colors_brain2(' num2str(k) ',:))'])
    end
end

hold off


% Sagital Sensory
ML=0.3;
win_sz=25;

%figure;
ax1=subplot(6,7,1);
[sag] = plotMLSlice(bregma(2)+ML*100,av,tv,st); 
imagesc(sag)
set(gca,'dataaspectratio',[1 1 1])
cmap = flipud(gray);
colormap(cmap)
hold on
for i=1:numel(MM.AP)
    plot(bregma(1)-MM.AP(i),bregma(3)+MM.DV(i),'Marker','o','MarkerSize',10,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',colors_brain2(MM.Sens(i),:))
end
set(gca,'XTick',[40 140 240 340 440 540 640 740 840 940 1040 1140 1240 1340]);
set(gca,'XTickLabel',[-5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8]);
xlabel('AP (mm)')
set(gca,'YTick',[65 165 265 365 465 565 665 765]);
set(gca,'YTickLabel',[0 -1 -2 -3 -4 -5 -6 -7]);
ylabel('DV (mm)')
title(['Sensory Modality, Sagital Projection at ' num2str(ML) ' mm'])


mm2=round(MM.AP);
x1=nan(1,size(av,1)); x2=nan(1,size(av,1)); x3=nan(1,size(av,1));
x4=nan(1,size(av,1)); x5=nan(1,size(av,1)); x6=nan(1,size(av,1));


for i=1:size(av,1)
    
    temp_i=find((bregma(1)-mm2)==i);
    
    if numel(temp_i)==1
        
        if MM.Sens(temp_i)==1
            x1(i)=1;
        end
        if MM.Sens(temp_i)==2
            x2(i)=1;
        end
        if MM.Sens(temp_i)==3
            x3(i)=1;
        end
        if MM.Sens(temp_i)==4
            x4(i)=1;
        end
        if MM.Sens(temp_i)==5
            x5(i)=1;
        end
        if MM.Sens(temp_i)==6
            x6(i)=1;
        end
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==1)
        x1(i)=numel(find(MM.Sens(temp_i)==1));
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==2)
        x2(i)=numel(find(MM.Sens(temp_i)==2));
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==3)
        x3(i)=numel(find(MM.Sens(temp_i)==3));
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==4)
        x4(i)=numel(find(MM.Sens(temp_i)==4));
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==5)
        x5(i)=numel(find(MM.Sens(temp_i)==5));
    end
    if numel(temp_i)>1 && any(MM.Sens(temp_i)==6)
        x6(i)=numel(find(MM.Sens(temp_i)==6));
    end
end

in=1;
out=win_sz;
step=1;
win_nb=(size(av,1)-out)/step;
win_centers=linspace(1,size(av,1)-out,win_nb);

s1=zeros(1,win_nb); s2=zeros(1,win_nb); s3=zeros(1,win_nb);
s4=zeros(1,win_nb); s5=zeros(1,win_nb); s6=zeros(1,win_nb);

for i=1:(win_nb)
    t1=nanmean(x1(in:out)); t2=nanmean(x2(in:out)); t3=nanmean(x3(in:out));
    t4=nanmean(x4(in:out)); t5=nanmean(x5(in:out)); t6=nanmean(x6(in:out));
    
    if ~isnan(t1)
        s1(i)=t1;
    end
    if ~isnan(t2)
        s2(i)=t2;
    end
    if ~isnan(t3)
        s3(i)=t3;
    end
    if ~isnan(t4)
        s4(i)=t4;
    end
    if ~isnan(t5)
        s5(i)=t5;
    end
    if ~isnan(t6)
        s6(i)=t6;
    end
    in=in+step;
    out=out+step;
end


g=gausswin(win_sz);
g2=g./trapz(g);

gk1_ap=conv(s1,g2,'same'); gk2_ap=conv(s2,g2,'same'); gk3_ap=conv(s3,g2,'same');
gk4_ap=conv(s4,g2,'same'); gk5_ap=conv(s5,g2,'same'); gk6_ap=conv(s6,g2,'same');

gk1_ap=[zeros(1,win_sz) gk1_ap]; gk2_ap=[zeros(1,win_sz) gk2_ap]; gk3_ap=[zeros(1,win_sz) gk3_ap];
gk4_ap=[zeros(1,win_sz) gk4_ap]; gk5_ap=[zeros(1,win_sz) gk5_ap]; gk6_ap=[zeros(1,win_sz) gk6_ap];


for k=1:6
    eval(['cumtrap_gk_ap' num2str(k) '=[];'])     
    if k~=5        
        for i=1:size(gk1_ap,2)
            eval(['cumtrap_gk_ap' num2str(k) '(i)=trapz(gk' num2str(k) '_ap(1:i));'])
        end
        eval(['mAP' num2str(k) '=find(cumtrap_gk_ap' num2str(k) '>=ceil(trapz(gk' num2str(k) '_ap)/2) & cumtrap_gk_ap' num2str(k) '<=ceil(trapz(gk' num2str(k) '_ap)/2)+1);'])
        eval(['tt=mAP' num2str(k) ';'])
          if isempty(tt)
           eval(['mAP' num2str(k) '=find(cumtrap_gk_ap' num2str(k) '>=ceil(trapz(gk' num2str(k) '_ap)/2) & cumtrap_gk_ap' num2str(k) '<=ceil(trapz(gk' num2str(k) '_ap)/2)+2);'])
          end
        
        eval(['plot(mAP' num2str(k) ',mDV' num2str(k) ',''Marker'',''diamond'',''MarkerSize'',20,''MarkerEdgeColor'',[0 0 0],''MarkerFaceColor'',colors_brain2(' num2str(k) ',:))'])
    end
end


ax2=subplot(6,7,2);
area(1:size(av,1),gk1_ap,'Facecolor',colors_brain2(1,:));
hold on
a22=area(1:size(av,1),gk2_ap,'Facecolor',colors_brain2(2,:));
a22.FaceAlpha=0.5;
a23=area(1:size(av,1),gk3_ap,'Facecolor',colors_brain2(3,:));
a23.FaceAlpha=0.5;
a24=area(1:size(av,1),gk4_ap,'Facecolor',colors_brain2(4,:));
a24.FaceAlpha=0.5;
a26=area(1:size(av,1),gk6_ap,'Facecolor',colors_brain2(6,:));
a26.FaceAlpha=0.5;
xlim([0 size(av,1)])
ylim([0 4])
set(gca,'XTick',[40 140 240 340 440 540 640 740 840 940 1040 1140 1240 1340]);
set(gca,'XTickLabel',{' '})

ax8=subplot(6,7,8);
area(1:size(av,3),gk1_ml,'Facecolor',colors_brain2(1,:))
hold on
a82=area(1:size(av,3),gk2_ml,'Facecolor',colors_brain2(2,:));
a82.FaceAlpha=0.5;
a83=area(1:size(av,3),gk3_ml,'Facecolor',colors_brain2(3,:));
a83.FaceAlpha=0.5;
a84=area(1:size(av,3),gk4_ml,'Facecolor',colors_brain2(4,:));
a84.FaceAlpha=0.5;
a86=area(1:size(av,3),gk6_ml,'Facecolor',colors_brain2(6,:));
a86.FaceAlpha=0.5;
set(gca,'XTick',[70 170 270 370 470 570 670 770 870 970 1070]);
set(gca,'XTickLabel',{' '})
xlim([0 size(av,3)])
ylim([0 4])

ax13=subplot(6,7,13);
area(1:size(av,2),gk1,'Facecolor',colors_brain2(1,:))
hold on
a132=area(1:size(av,2),gk2,'Facecolor',colors_brain2(2,:));
a132.FaceAlpha=0.5;
a133=area(1:size(av,2),gk3,'Facecolor',colors_brain2(3,:));
a133.FaceAlpha=0.5;
a134=area(1:size(av,2),gk4,'Facecolor',colors_brain2(4,:));
a134.FaceAlpha=0.5;
a136=area(1:size(av,2),gk6,'Facecolor',colors_brain2(6,:));
a136.FaceAlpha=0.5;
set(gca, 'XDir','reverse')
set(gca,'XTick',[70 170 270 370 470 570 670 770 870 970 1070]);
set(gca,'XTickLabel',{' '})
xlim([0 size(av,2)])
ylim([0 2.5])
view([90 -90])
title(['Smoothing window: ' num2str(win_sz) ' um'])

% Sagital plot
set(ax1, 'position',[0.025, 0.65, 0.45, 0.3]);
set(ax2, 'position',[0.025 , 0.55, 0.45, 0.07]);
set(ax7, 'position',[0.49 , 0.65, 0.35, 0.3]);
set(ax8, 'position',[0.49 , 0.55, 0.35, 0.07]);
set(ax13, 'position',[0.85, 0.65, 0.07, 0.3]);

set(gcf,'units','points','position',[700,1000,1320,1150])

%% Task Type
colors_brain3=hex2rgb(Task);
AP=1.95;
win_sz=25;

figure;

ax5=subplot(4,5,5);
[corr]= plotAPSlice(bregma(1)-AP*100,av,tv,st); 
imagesc(corr)
set(gca,'dataaspectratio',[1 1 1])
cmap = flipud(gray);
colormap(cmap)
hold on
for i=1:numel(MM.AP)
    plot(bregma(2)+MM.ML(i),bregma(3)+MM.DV(i),'Marker','o','MarkerSize',10,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',colors_brain3(MM.Task(i),:))
end
set(gca,'XTick',[70 170 270 370 470 570 670 770 870 970 1070]);
set(gca,'XTickLabel',[-5 -4 -3 -2 -1 0 1 2 3 4 5]);
xlabel('ML (mm)')
set(gca,'YTick',[65 165 265 365 465 565 665 765]);
set(gca,'YTickLabel',[0 -1 -2 -3 -4 -5 -6 -7]);
%ylabel('DV (mm)')
set(gca,'YTickLabel',{' '})
title(['Task Type, Coronal Projection at ' num2str(AP) ' mm'])

%Spatial smoothing DV
mm2=round(MM.DV);
x1=nan(1,size(av,2)); x2=nan(1,size(av,2)); x3=nan(1,size(av,2));

cnt6=0;

for i=1:size(av,2)
    
    temp_i=find((mm2+bregma(3))==i);
    
    if numel(temp_i)==1
        
        if MM.Task(temp_i)==1
            x1(i)=1;
        end
        if MM.Task(temp_i)==2
            x2(i)=1;
        end
        if MM.Task(temp_i)==3
            x3(i)=1;
        end
    end
    if numel(temp_i)>1 && any(MM.Task(temp_i)==1)
        x1(i)=numel(find(MM.Task(temp_i)==1));
    end
    if numel(temp_i)>1 && any(MM.Task(temp_i)==2)
        x2(i)=numel(find(MM.Task(temp_i)==2));
    end
    if numel(temp_i)>1 && any(MM.Task(temp_i)==3)
        x3(i)=numel(find(MM.Task(temp_i)==3));
    end
end

in=1;
out=win_sz;
step=1;
win_nb=(size(av,2)-out)/step;
win_centers=linspace(1,size(av,2)-out,win_nb);
s1=zeros(1,win_nb); s2=zeros(1,win_nb); s3=zeros(1,win_nb);

for i=1:(win_nb)
    t1=nanmean(x1(in:out)); t2=nanmean(x2(in:out)); t3=nanmean(x3(in:out));
    
    if ~isnan(t1)
        s1(i)=t1;
    end
    if ~isnan(t2)
        s2(i)=t2;
    end
    if ~isnan(t3)
        s3(i)=t3;
    end
    
    in=in+step;
    out=out+step;
end


g=gausswin(win_sz);
g2=g./trapz(g);

gk1=conv(s1,g2,'same'); gk2=conv(s2,g2,'same'); gk3=conv(s3,g2,'same');

gk1=[zeros(1,win_sz) gk1]; gk2=[zeros(1,win_sz) gk2]; gk3=[zeros(1,win_sz) gk3];

% Spatial smoothing ML
mm2=round(MM.ML);
x1=nan(1,size(av,3)); x2=nan(1,size(av,3)); x3=nan(1,size(av,3));


for i=1:size(av,3)
    
    temp_i=find((mm2+bregma(2))==i);
    
    if numel(temp_i)==1
        
        if MM.Task(temp_i)==1
            x1(i)=1;
        end
        if MM.Task(temp_i)==2
            x2(i)=1;
        end
        if MM.Task(temp_i)==3
            x3(i)=1;
        end
    end
    if numel(temp_i)>1 && any(MM.Task(temp_i)==1)
        x1(i)=numel(find(MM.Task(temp_i)==1));
    end
    if numel(temp_i)>1 && any(MM.Task(temp_i)==2)
        x2(i)=numel(find(MM.Task(temp_i)==2));
    end
    if numel(temp_i)>1 && any(MM.Task(temp_i)==3)
        x3(i)=numel(find(MM.Task(temp_i)==3));
    end
end

in=1;
out=win_sz;
step=1;
win_nb=(size(av,3)-out)/step;
win_centers=linspace(1,size(av,3)-out,win_nb);
s1=zeros(1,win_nb); s2=zeros(1,win_nb); s3=zeros(1,win_nb);

for i=1:(win_nb)
    t1=nanmean(x1(in:out)); t2=nanmean(x2(in:out)); t3=nanmean(x3(in:out));
    
    if ~isnan(t1)
        s1(i)=t1;
    end
    if ~isnan(t2)
        s2(i)=t2;
    end
    if ~isnan(t3)
        s3(i)=t3;
    end
    
    in=in+step;
    out=out+step;
end


g=gausswin(win_sz);
g2=g./trapz(g);

gk1_ml=conv(s1,g2,'same'); gk2_ml=conv(s2,g2,'same'); gk3_ml=conv(s3,g2,'same');

gk1_ml=[zeros(1,win_sz) gk1_ml]; gk2_ml=[zeros(1,win_sz) gk2_ml]; gk3_ml=[zeros(1,win_sz) gk3_ml];

for k=1:3
    eval(['cumtrap_gk' num2str(k) '=[];'])
    eval(['cumtrap_gk' num2str(k) '_ml=[];'])
    if k~=5
        for i=1:size(gk1,2)
            eval([' cumtrap_gk' num2str(k) '(i)=trapz(gk' num2str(k) '(1:i));'])
        end
        eval(['mDV' num2str(k) '=find(cumtrap_gk' num2str(k) '>=ceil(trapz(gk' num2str(k) ')/2),1,' '''first''' ');'])
        
        for i=1:size(gk1_ml,2)
            eval(['cumtrap_gk' num2str(k) '_ml(i)=trapz(gk' num2str(k) '_ml(1:i));'])
        end
        eval(['mML' num2str(k) '=find(cumtrap_gk' num2str(k) '_ml>=ceil(trapz(gk' num2str(k) '_ml)/2),1,' '''first''' ');'])                  
        eval(['plot(mML' num2str(k) ',mDV' num2str(k) ',''Marker'',''diamond'',''MarkerSize'',20,''MarkerEdgeColor'',[0 0 0],''MarkerFaceColor'',colors_brain3(' num2str(k) ',:))'])
    end
end

hold off


% Sagital Task
ML=0.3;
win_sz=25;


ax1=subplot(4,5,1);
[sag] = plotMLSlice(bregma(2)+ML*100,av,tv,st); 
imagesc(sag)
set(gca,'dataaspectratio',[1 1 1])
cmap = flipud(gray);
colormap(cmap)
hold on
for i=1:numel(MM.AP)
    plot(bregma(1)-MM.AP(i),bregma(3)+MM.DV(i),'Marker','o','MarkerSize',10,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',colors_brain3(MM.Task(i),:))
end
set(gca,'XTick',[40 140 240 340 440 540 640 740 840 940 1040 1140 1240 1340]);
set(gca,'XTickLabel',[-5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8]);
xlabel('AP (mm)')
set(gca,'YTick',[65 165 265 365 465 565 665 765]);
set(gca,'YTickLabel',[0 -1 -2 -3 -4 -5 -6 -7]);
ylabel('DV (mm)')
title(['Complexity Index, Sagital Projection at ' num2str(ML) ' mm'])


mm2=round(MM.AP);
x1=nan(1,size(av,1)); x2=nan(1,size(av,1)); x3=nan(1,size(av,1));


for i=1:size(av,1)
    
    temp_i=find((bregma(1)-mm2)==i);
    
    if numel(temp_i)==1
        
        if MM.Task(temp_i)==1
            x1(i)=1;
        end
        
        if MM.Task(temp_i)==2
            x2(i)=1;
        end
        
        if MM.Task(temp_i)==3
            x3(i)=1;
        end
    end
    
    if numel(temp_i)>1 && any(MM.Task(temp_i)==1)
        x1(i)=numel(find(MM.Task(temp_i)==1));
    end
    
    if numel(temp_i)>1 && any(MM.Task(temp_i)==2)
        x2(i)=numel(find(MM.Task(temp_i)==2));
    end
    
    if numel(temp_i)>1 && any(MM.Task(temp_i)==3)
        x3(i)=numel(find(MM.Task(temp_i)==3));
    end
    
end

in=1;
out=win_sz;
step=1;
win_nb=(size(av,1)-out)/step;
win_centers=linspace(1,size(av,1)-out,win_nb);

s1=zeros(1,win_nb); s2=zeros(1,win_nb); s3=zeros(1,win_nb);

for i=1:(win_nb)
    t1=nanmean(x1(in:out)); t2=nanmean(x2(in:out)); t3=nanmean(x3(in:out));
    
    if ~isnan(t1)
        s1(i)=t1;
    end
    if ~isnan(t2)
        s2(i)=t2;
    end
    if ~isnan(t3)
        s3(i)=t3;
    end
    in=in+step;
    out=out+step;
end


g=gausswin(win_sz);
g2=g./trapz(g);

gk1_ap=conv(s1,g2,'same'); gk2_ap=conv(s2,g2,'same'); gk3_ap=conv(s3,g2,'same');

gk1_ap=[zeros(1,win_sz) gk1_ap]; gk2_ap=[zeros(1,win_sz) gk2_ap]; gk3_ap=[zeros(1,win_sz) gk3_ap];

for k=1:3
    eval(['cumtrap_gk_ap' num2str(k) '=[];'])
            
        for i=1:size(gk1_ap,2)
            eval(['cumtrap_gk_ap' num2str(k) '(i)=trapz(gk' num2str(k) '_ap(1:i));'])
        end
        eval(['mAP' num2str(k) '=find(cumtrap_gk_ap' num2str(k) '>=ceil(trapz(gk' num2str(k) '_ap)/2),1,' '''first''' ');'])
        
        eval(['plot(mAP' num2str(k) ',mDV' num2str(k) ',''Marker'',''diamond'',''MarkerSize'',20,''MarkerEdgeColor'',[0 0 0],''MarkerFaceColor'',colors_brain3(' num2str(k) ',:))'])

end


ax2=subplot(4,5,2);
area(1:size(av,1),gk1_ap,'Facecolor',colors_brain3(1,:))
hold on
a22=area(1:size(av,1),gk2_ap,'Facecolor','w');
a22.FaceAlpha = 0.5;
a23=area(1:size(av,1),gk3_ap,'Facecolor',colors_brain3(3,:));
a23.FaceAlpha = 0.5;
xlim([0 size(av,1)])
ylim([0 5])
set(gca,'XTick',[40 140 240 340 440 540 640 740 840 940 1040 1140 1240 1340]);
set(gca,'XTickLabel',{' '})
title(['Smoothing window: ' num2str(win_sz) ' um'])

ax9=subplot(4,5,9);
area(1:size(av,2),gk1,'Facecolor',colors_brain3(1,:))
hold on
a92=area(1:size(av,2),gk2,'Facecolor','w');
a92.FaceAlpha = 0.5;
a93=area(1:size(av,2),gk3,'Facecolor',colors_brain3(3,:));
a93.FaceAlpha = 0.5;
set(ax9, 'XDir','reverse')
set(gca,'XTick',[70 170 270 370 470 570 670 770 870 970 1070]);
set(gca,'XTickLabel',{' '})
xlim([0 size(av,2)])
ylim([0 3])
view([90 -90])
title(['Smoothing window: ' num2str(win_sz) ' um'])

ax6=subplot(4,5,6);
a61=area(1:size(av,3),gk1_ml,'Facecolor',colors_brain3(1,:));
hold on
a62=area(1:size(av,3),gk2_ml,'Facecolor',colors_brain3(2,:));
a62.FaceAlpha = 0.5;
a63=area(1:size(av,3),gk3_ml,'Facecolor',colors_brain3(3,:));
a63.FaceAlpha = 0.5;
set(gca,'XTick',[70 170 270 370 470 570 670 770 870 970 1070]);
set(gca,'XTickLabel',{' '})
xlim([0 size(av,3)])
ylim([0 5.5])
title(['Smoothing window: ' num2str(win_sz) ' um'])

% sagital
set(ax1, 'position',[0.025, 0.65, 0.45, 0.3]);
set(ax2, 'position',[0.025 , 0.55, 0.45, 0.075]);

%coronal
set(ax5, 'position',[0.49 , 0.65, 0.35, 0.3]);
set(ax6, 'position',[0.49 , 0.55, 0.35, 0.075]);
set(ax9, 'position',[0.85, 0.65, 0.075, 0.3]);
set(gcf,'units','points','position',[700,1000,1320,1150])




