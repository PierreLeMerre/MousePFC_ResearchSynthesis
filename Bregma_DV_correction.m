function corr_DV = Bregma_DV_correction(AP,ML)

AP=AP*100;
ML=ML*100;

%% Get Allen Data
[av,st,tv]=get_Allen_Data();
%% Get Bregma
bregma = allenCCFbregma;
bregma=[bregma(1) bregma(3) bregma(2)];
bregma(3)=65; %correction

corr_DV = get_APSlice_surfacedepth(double(av>1), bregma(1)-AP, ML, bregma);
corr_DV=corr_DV+bregma(3);
corr_DV=corr_DV/100;

end