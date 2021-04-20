
function bregma = allenCCFbregma()
% Adapted from the Cortex lab repository : allenCCF/Browsing Functions/allenCCFbregma()
%
% Return an estimate of the coordinates of bregma in allen CCF 10um volume coordinates
% This is just an estimate by me (see readme.md), the only one that's definitely right is
% the third dimension which is the midline
bregma = [540 65 570]; % AP, DV, LR
