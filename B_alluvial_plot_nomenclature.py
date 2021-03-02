#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jan 15 10:16:32 2020

@author: pielem
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
from matplotlib.path import Path
from matplotlib.patches import Rectangle

def singleAlluvium(leftSide, rightSide, color, alpha=0.4, tilt=0.5, xLeft=0, xRight=1):
    pathData = [
        (Path.MOVETO, [xLeft, leftSide[0]]),
        (Path.CURVE4, [xLeft+tilt, leftSide[0]]),
        (Path.CURVE4, [xRight-tilt, rightSide[0]]),
        (Path.CURVE4, [xRight, rightSide[0]]),
        (Path.LINETO, [xRight, rightSide[1]]),
        (Path.CURVE4, [xRight-tilt, rightSide[1]]),
        (Path.CURVE4, [xLeft+tilt, leftSide[1]]),
        (Path.CURVE4, [xLeft, leftSide[1]]),
        (Path.CLOSEPOLY, [xLeft, leftSide[0]])
    ]
    codes, verts = zip(*pathData)
    verts = np.array(verts)# + pos[np.newaxis, :]
    path = Path(verts, codes)
    patch = matplotlib.patches.PathPatch(path, linewidth=0, color=color, alpha=alpha)
    return patch

def alluvialPlot(data, leftSide, rightSide, colormap=dict(), ax=None, alpha=0.4,
                 tilt=0.6, colorByRight=False, leftOrder=None, rightOrder=None):
    '''
    Show co-occurencies of datapoints in a dataframe as an alluvial plot.
    
    Arguments:
    data - A pandas DataFrame with one row per observation.
    leftSide - A string indicating which column should be the left side
    rightSide - A string indicating which column should be the right side
    
    Optional arguments:
    colormap - A dictionary indicating which color to use for each label
    ax - The matplotlib axis to add the alluvial plot to
    alpha - Opacity of the plot
    tilt - Control parameter of the shape (0 to 1). Small values mean
           straighter lines, large values mean sharper turns.
    colorByRight - Color the alluvial according to the right side instead
                   of the left side (defualt False, i.e. use left side)
    leftOrder - A list with the order of items on the left side. Items not included
                in the list will not be plotted.
    rightOrder - Same as leftOrder, but for the right side.
    '''
    #Calculate y-coordinates (lower and higher) for left and right side respectively
    leftY = data.groupby([leftSide, rightSide]).size()
    if leftOrder is not None:
        leftY = leftY.reindex(leftOrder, level=0)
    leftY = np.cumsum(leftY) / leftY.sum() * 0.9
    leftY = pd.DataFrame({'lower': leftY.shift(1, fill_value=0), 'higher': leftY})
    ind = leftY.index.remove_unused_levels()
    offset = 0.1*ind.codes[0] / (ind.levels[0].size-1)
    leftY += offset[:, np.newaxis]
    rightY = data.groupby([rightSide, leftSide]).size()    
    if rightOrder is not None:
        rightY = rightY.reindex(rightOrder, level=0)        
    rightY = np.cumsum(rightY)  / len(data) * 0.9
    rightY = pd.DataFrame({'lower': rightY.shift(1, fill_value=0), 'higher': rightY})
    ind = rightY.index.remove_unused_levels()
    offset = 0.1*ind.codes[0] / (ind.levels[0].size-1)
    rightY += offset[:, np.newaxis]
    rightY = rightY.reorder_levels([1,0]).reindex_like(leftY)
    
    #Create a new figure if no axis specified
    if ax is None:
        ax = plt.axes()
        ax.axis([-0.2, 1.2, 0, 1])

    #Add indiviual alluvia
    
    for (ind, ls), (ind, rs) in zip(leftY.iterrows(), rightY.iterrows()):
        for i in range(2):
            if ind[i] not in colormap:
                colormap[ind[i]] = np.random.uniform(size=3)
        if ls[1] > ls[0]: #At least one sample
            patch = singleAlluvium(ls, rs, colormap[ind[colorByRight]], alpha, tilt)
            ax.add_artist(patch)

            ax.add_artist(Rectangle((-0.2, ls[0]), 0.2, ls[1]-ls[0], color=colormap[ind[0]],
                          fill=True, lw=0, alpha=alpha))
            ax.add_artist(Rectangle((1, rs[0]), 0.2, rs[1]-rs[0], color=colormap[ind[1]],
                          fill=True, lw=0, alpha=alpha))

# Alluvial plot for PFC metaanalysis data
file_location = "/Users/pierre/Google Drive/PFC-Review-REVISED-2/Meta-analysis/Table1-Database.xlsx"
df = pd.read_excel(file_location)
d = df[['Area Name','Allen Area']]  #select two columns in df
cmap = {'MOs': 'C0', 'ACA': 'C1', 'PL': 'C2', 'IL': 'C3',
        'mOFC': 'C4', 'vlOFC': 'C5', 'lOFC': 'C6'}
#cmap2 = {an: 'C'+str(i%8) for i, an in enumerate(d['Area Name'].unique())}
#cmap2.update(cmap)
alluvialPlot(d, 'Allen Area', 'Area Name', cmap,
             leftOrder=['MOs','ACA','PL','ILA','ORBm','ORBvl','ORBl'],
             rightOrder=['MOs', 'M2', 'aM2', 'ALM', 'MFC', 'fMC', 'RFA', 'dmPFC', 'AC','ACC', 'dACC', 'Cg','A24b',
                          'mPFC', 'PFC', 'PL','PrL','PL - IL','IfL-C','IL','IL-PFC','vmPFC', 'OFC','vmOFC']
                         )
plt.axis("off")
plt.savefig("alluvialPlot.svg")
plt.show()





