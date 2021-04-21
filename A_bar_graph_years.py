#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Mar  1 14:35:59 2021

@author: pierre
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

file_location = "/Path/To/Table1-Database.xlsx"
df = pd.read_excel(file_location) # for xlsx
# df = pd.read_csv(file_location, sep=';') # for csv
d = df[['Year']]  #select two columns in df
(unique, counts) = np.unique(d.Year,return_counts=True)

fig = plt.figure()
years = [ '2011', '2012', '2013', '2014','2015', '2016', '2017', '2018', '2019','2020']
plt.bar(years,counts, color ='#214566',  
        width = 0.8) 
plt.xlabel("Years") 
plt.ylabel("Publications") 
plt.title("Dataset") 
plt.show()
