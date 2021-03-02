function [av,st,tv]=get_Allen_Data()

%% Get the Allen Data
% directory of reference atlas files
annotation_volume_location = '/Users/pierre/Documents/MATLAB/AllenCCF/Data_Allen/annotation_volume_10um_by_index.npy';
structure_tree_location = '/Users/pierre/Documents/MATLAB/AllenCCF/Data_Allen/structure_tree_safe_2017.csv';
template_volume_location = '/Users/pierre/Documents/MATLAB/AllenCCF/Data_Allen/template_volume_10um.npy';

% load the reference brain and region annotations
if ~exist('av','var') || ~exist('st','var') || ~exist('tv','var')
    disp('loading reference atlas...')
    av = readNPY(annotation_volume_location);
    st = loadStructureTree(structure_tree_location);
    tv = readNPY(template_volume_location);
end

%% permute for the allen browser
tv = permute(tv,[2 1 3]);
end