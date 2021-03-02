#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Mar  2 13:35:53 2021

@author: pierre
"""

from plotly import __version__
from plotly.offline import download_plotlyjs, init_notebook_mode, plot, iplot
import plotly.graph_objs as go
from plotly import tools
import numpy as np
import pandas as pd
import xlrd

def show(fig):
  import io
  import plotly.io as pio
  from PIL import Image
  buf = io.BytesIO()
  pio.write_image(fig, buf)
  img = Image.open(buf)
  img.show() 
  
  
  
#Import Ref Columnfrom excel
file_location = "/Users/pierre/Google Drive/PFC-Review-REVISED-2/Meta-analysis/Table1-Database.xlsx"
workbook = xlrd.open_workbook(file_location)
sheet = workbook.sheet_by_name('Table1-Database')
refs = []
for rownum in range(sheet.nrows):
  refs.append(sheet.row_values(rownum, 1,2))
#print(refs)
refs.pop(0) #remove first element
refs=[str(r[0]) for r in refs] # Very nice python way from emil


#Import Complexity Index Columnfrom excel
workbook = xlrd.open_workbook(file_location)
sheet = workbook.sheet_by_name('Table1-Database')
cplxIDX = []
for rownum in range(sheet.nrows):
  cplxIDX.append(sheet.row_values(rownum, 14,15))
cplxIDX.pop(0) #remove first element   
cplxIDX=[str(r[0]) for r in cplxIDX] # Very nice python way from emil
ccplx=list(map(float, cplxIDX[:]))

#Import SENSPAEMO Index Columnfrom excel
workbook = xlrd.open_workbook(file_location)
sheet = workbook.sheet_by_name('Table1-Database')
sseIDX = []
for rownum in range(sheet.nrows):
  sseIDX.append(sheet.row_values(rownum, 16,17))
sseIDX.pop(0) #remove first element   
sseIDX=[str(r[0]) for r in sseIDX] # Very nice python way from emil
csse=list(map(float, sseIDX[:]))

#Import sensory modality Index Columnfrom excel
workbook = xlrd.open_workbook(file_location)
sheet = workbook.sheet_by_name('Table1-Database')
smIDX = []
for rownum in range(sheet.nrows):
  smIDX.append(sheet.row_values(rownum, 15,16))
smIDX.pop(0) #remove first element   
smIDX=[str(r[0]) for r in smIDX] # Very nice python way from emil
csm=list(map(float, smIDX[:]))
#print(cplxIDX) 


#Import sensory modality Index Columnfrom excel
workbook = xlrd.open_workbook(file_location)
sheet = workbook.sheet_by_name('Table1-Database')
ap = []
for rownum in range(sheet.nrows):
  ap.append(sheet.row_values(rownum, 8,9))
ap.pop(0) #remove first element   
ap=[str(r[0]) for r in ap] # Very nice python way from emil
aap=list(map(float, ap[:]))

ml = []
for rownum in range(sheet.nrows):
  ml.append(sheet.row_values(rownum, 9,10))
ml.pop(0) #remove first element   
ml=[str(r[0]) for r in ml] # Very nice python way from emil
mml=list(map(float, ml[:]))

dv = []
for rownum in range(sheet.nrows):
  dv.append(sheet.row_values(rownum, 11,12))
dv.pop(0) #remove first element   
dv=[str(r[0]) for r in dv] # Very nice python way from emil
ddv=list(map(float, dv[:]))


verticesbrain = pd.read_csv('/Users/pierre/Google Drive/PFC-Review-REVISED-2/Meta-analysis/Code/Brain_meshes/Brain/vertices.csv',header=None)
indicesbrain = pd.read_csv('/Users/pierre/Google Drive/PFC-Review-REVISED-2/Meta-analysis/Code/Brain_meshes/Brain/indices.csv',header=None)   
verticesdmPFC = pd.read_csv('/Users/pierre/Google Drive/PFC-Review-REVISED-2/Meta-analysis/Code/Brain_meshes/dmPFC/vertices.csv',header=None)
indicesdmPFC = pd.read_csv('/Users/pierre/Google Drive/PFC-Review-REVISED-2/Meta-analysis/Code/Brain_meshes/dmPFC/indices.csv',header=None)
verticesvmPFC = pd.read_csv('/Users/pierre/Google Drive/PFC-Review-REVISED-2/Meta-analysis/Code/Brain_meshes/vmPFC/vertices.csv',header=None)
indicesvmPFC = pd.read_csv('/Users/pierre/Google Drive/PFC-Review-REVISED-2/Meta-analysis/Code/Brain_meshes/vmPFC/indices.csv',header=None)
verticesvlPFC = pd.read_csv('/Users/pierre/Google Drive/PFC-Review-REVISED-2/Meta-analysis/Code/Brain_meshes/vlPFC/vertices.csv',header=None)
indicesvlPFC = pd.read_csv('/Users/pierre/Google Drive/PFC-Review-REVISED-2/Meta-analysis/Code/Brain_meshes/vlPFC/indices.csv',header=None)

xbrain = verticesbrain.loc[:,0]/100
ybrain = verticesbrain.loc[:,1]/100
zbrain = verticesbrain.loc[:,2]/100
ibrain = indicesbrain.loc[:,0]-1
jbrain = indicesbrain.loc[:,1]-1
kbrain = indicesbrain.loc[:,2]-1
xdmPFC = verticesdmPFC.loc[:,0]/100
ydmPFC = verticesdmPFC.loc[:,1]/100
zdmPFC = verticesdmPFC.loc[:,2]/100
idmPFC = indicesdmPFC.loc[:,0]-1
jdmPFC = indicesdmPFC.loc[:,1]-1
kdmPFC = indicesdmPFC.loc[:,2]-1
xvmPFC = verticesvmPFC.loc[:,0]/100
yvmPFC = verticesvmPFC.loc[:,1]/100
zvmPFC = verticesvmPFC.loc[:,2]/100
ivmPFC = indicesvmPFC.loc[:,0]-1
jvmPFC = indicesvmPFC.loc[:,1]-1
kvmPFC = indicesvmPFC.loc[:,2]-1
xvlPFC = verticesvlPFC.loc[:,0]/100
yvlPFC = verticesvlPFC.loc[:,1]/100
zvlPFC = verticesvlPFC.loc[:,2]/100
ivlPFC = indicesvlPFC.loc[:,0]-1
jvlPFC = indicesvlPFC.loc[:,1]-1
kvlPFC = indicesvlPFC.loc[:,2]-1

df = pd.DataFrame(list(zip(aap, mml, ddv)), 
               columns =['AP', 'ML', 'DV'])
AP = -df.loc[:,'AP']
ML = -df.loc[:,'ML']
DV = -df.loc[:,'DV']



scatter1 = dict(
  mode = "markers",
  name = "y",
  type = "scatter3d",   
  x = AP, y = ML, z = DV,
  showlegend=False,
  marker = dict( size=10, color=ccplx, colorscale='Reds', 
         colorbar = dict(title = 'Complexity Index',
                 nticks=10,
                 ), 
  line = dict(width=1, color="rgb(255, 255, 255)"),
         ), # set color to an array/list of desired values
  hoverinfo = "text",
  text= refs # The hover text goes here... 
)
clustersbrain = dict(
  alphahull = 7,
  name = "Brain",
  opacity = 0.2,
  flatshading = True,
  hoverinfo = "none",
  type = "mesh3d",
  color='#D3D3D3',
  x = xbrain, y = ybrain, z = zbrain,
  i = ibrain, j = jbrain, k = kbrain 
)
clustersdmPFC = dict(
  alphahull = 7,
  name = "dmPFC",
  opacity = 0.5,
  flatshading = True,
  hoverinfo = "none",
  type = "mesh3d",
  color='#AA2F22',
  x = xdmPFC, y = ydmPFC, z = zdmPFC,
  i = idmPFC, j = jdmPFC, k = kdmPFC 
)
clustersvmPFC = dict(
  alphahull = 7,
  name = "vmPFC",
  opacity = 0.5,
    flatshading = True,
  hoverinfo = "none",
  #showlegend=True,
  type = "mesh3d",
  color='#009ECA',   
  x = xvmPFC, y = yvmPFC, z = zvmPFC,
  i = ivmPFC, j = jvmPFC, k = kvmPFC
)
clustersvlPFC = dict(
  alphahull = 7,
  name = "vlPFC",
  opacity = 0.5,
  flatshading = True,
  hoverinfo = "none",
  type = "mesh3d",
  color='#E68859',   
  x = xvlPFC, y = yvlPFC, z = zvlPFC,
  i = ivlPFC, j = jvlPFC, k = kvlPFC
)
layout = dict(
  title = 'Mouse PFC Metadata Analysis v4.0',
  scene = dict(
    xaxis = dict( title='AP (mm)',
           zeroline=False,
           showgrid=True,
           range=[-7,8.5]),
    yaxis = dict( title='ML (mm)',
           zeroline=False,
           showgrid=True,
           range=[-6,6]),
    zaxis = dict( title='DV (mm)',
           zeroline=False,
           showgrid=True,
           range=[-7.5,0.5]
           ),
    aspectratio = dict(x=1, y=12/15.5, z=8/15.5)
  ),
  showlegend = True
  #aspectmode = 'manual', 
)
updatemenus=list([
  dict(
    buttons=list([ 
      dict(label = 'All',
         method = 'update',
         args = [{'visible': [True, True, True, True, True]}]),
      dict(label = 'Brain ON',
         method = 'update',
         args = [{'visible': [True, True, True, True, True]}]),
      dict(label = 'Brain OFF',
         method = 'update',
         args = [{'visible': [True, False, True, True, True]}]),
      dict(
        args = [{'visible': [True, False, True, False, False]}],
        label='dmPFC',
        method='update'
      ),
      dict(
        args = [{'visible': [True, False , False, True, False]}],
        label='vmPFC',
        method='update'
      ),
      dict(
        args = [{'visible': [True, False, False, False, True]}],
        label='vlPFC',
        method='update'
      ), 
      dict(
        args = [{'visible': [True, False, False, False, False]}],
        label='None',
        method='update'
      ), 
    ]),
    direction = 'left',
    pad = {'r': 10, 't': 10},
    showactive = True,
    type = 'buttons',
    x = 0.11,
    xanchor = 'left',
    y = 1.07,
    yanchor = 'top' 
  ),
  dict(
    buttons=list([ 
      dict(label = 'Complexity Index',
         method = 'update',
         args = [{'marker.color': [ccplx, 'none', 'none', 'none', 'none'],
             'marker.colorscale': 'Reds',
             'marker.colorbar.title': 'Complexity Index',
             'marker.colorbar.nticks': 10,
             }]),      
      dict(label = 'Task Type',
         method = 'update',
         args = [{'marker.color': [csse, 'none', 'none', 'none', 'none'],
             'marker.colorscale': 'RdBu',
             'marker.colorbar.title': 'Task Type',
             'marker.colorbar.nticks': 3
             }]),      
      dict(label = 'Sensory Modality',
         method = 'update',
         args = [{'marker.color': [csm, 'none', 'none', 'none', 'none'],
             'marker.colorscale': 'Portland',
             'marker.colorbar.title': 'Sensory Modality',
             'marker.colorbar.nticks': 6
             }]),      
    ]),
    direction = 'left',
    pad = {'r': 10, 't': 10},
    showactive = True,
    type = 'buttons',
    x = 0.11,
    xanchor = 'left',
    y = 1,
    yanchor = 'top' 
  ), 
])
annotations = list([
  dict(text='Subnetwork to plot:', x=0, y=1.045, yref='paper', align='left', showarrow=False),
  dict(text='Metadata to plot:', x=0, y=0.97, yref='paper', align='left', showarrow=False),
])
layout['updatemenus'] = updatemenus
layout['annotations'] = annotations 
fig = dict( data=[scatter1, clustersbrain, clustersdmPFC, clustersvmPFC, clustersvlPFC], layout=layout )
#fig = dict( data=[scatter, clustersMO, clustersACA], layout=layout )

plot(fig, filename='Mouse_PFC_Metadata_Analysis_v4.0.html')



