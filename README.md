# MousePFC_ResearchSynthesis
Code used to generate the Research synthesis figures.

## Database
[Download the database](https://carlenlab.org/data-protected/)

## Requirements for Matlab code
- MATLAB (R2017 and on)
- This repository (add all folders and subfolders to your MATLAB path)
- [The npy-matlab repository](http://github.com/kwikteam/npy-matlab)
- [The Allen Mouse Brain Atlas volume and annotations](http://download.alleninstitute.org/informatics-archive/current-release/mouse_ccf/)

## Instructions
 - For Python code
Update the paths to the table and meshes in the python scripts to point where you downloaded the files.

- For Matlab code
Add the matlab the scripts and folders to your Matlab path.
Update the paths to the table in the matlab scripts to point where you downloaded the files.

## Bregma in CCFv3

The Allen Institute always explicitly stated that they do not have a definition for Bregma, as they state for the ~1600 adult mouse brains used to construct th CCFv3: “Each one of those brains was dissected from a skull, and every skull has a slightly different Bregma location; hence the CCF does not have a single brain-in-skull as a source (which would have a corresponding Bregma coordinate), but is made from brains out-of-skull that have been registered to achieve an ‘average’ volume that is defined by the brain itself, ex cranio. “ (source [here](https://community.brain-map.org/t/why-doesnt-the-3d-mouse-brain-atlas-have-bregma-coordinates/158)). Therefore we had to place Bregma ourselves in the CCFv3. We placed Bregma based on the information available in the first version (CCFv1) of the ARA and how others labs have placed it (see the [Github repo of the Cortex lab](https://github.com/cortex-lab/allenCCF) from where we derived our scripts). We carefully commented on this fact (in the matlab script “AllenCCFBregma.m”) to provide transparency and reproducibility for other users.

## DV Correction

Experimenters report the Bregma DV coordinate either relative to Brain surface or relative to Bregma 0 (skull landmark). In the Table1-Database we performed DV corrections to obtain the DV coordinate into the CCFv3. When Bregma was reported form brain surface, we performed a correction with the matlab script “Bregma_DV_correction.mat”. This script plots the contours of the coronal section for the AP and ML coordinates provided in the referenced publication and finds the distance between brain the brain surface and the CCFv3 Bregma. This value needs to be added to the mean DV value provided in the original publication: column "Allen Atlas tilt DV Corr" in Table1-Database. When Bregma was reported from Bregma 0 (skull landmark) we performed both a fixed correction to account for the skull thickness and our tilt correction with the script “Bregma_DV_correction.mat”. 


## Source
© 2015 Allen Institute for Brain Science. Allen Mouse Brain Atlas (2015) with region annotations (2017).

