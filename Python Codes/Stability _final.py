# -*- coding: utf-8 -*-
"""
Created on Sat Jan 11 01:12:57 2025

@author: lebia


"""

import sympy as sp
import  matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d import Axes3D


a = 0.2 #Radius of the Cylinder in 'm'
l = 1#length of the cylinder in 'm'
n_r =10 #number of Control Volues along radius]
n_z = 50 #number of Control Volumes along length 'z'
t = 10 #time in seconds


del_z = l/n_z
del_r = a/n_r

theta = np.linspace(0,180, num=10)#Theta values
theta_rad = np.radians(theta)
theta_d = np.linspace(0,180,num=10) #Theta_d values
theta_d_rad = np.radians(theta_d)
CFL_z_guess = np.linspace(0.01,2,num=25) #CFL_z Values

Fo_r_guess = np.linspace(0,1,num=25)#Fo_r Values
Fo_z_guess =np.linspace(0,1,num=25)#Fo_z Values
j_location = np.linspace((del_r/2),a-(del_r/2),num=n_r) #Location of the cell centre centre along radius

G_values = []
CFL_zvalues = []
Fo_rvalues = []
Fo_zvalues = []
th_values =[]
th_d_values = []

for CFL_z in CFL_z_guess:
    for Fo_r in Fo_r_guess:
        for Fo_z in Fo_z_guess:
            for j in j_location:
                for th in theta_rad:
                    for th_d in theta_d_rad:
                        r_ph = 2*del_r
                        r_mh = del_r
                        
                        real = (1+ (CFL_z*(np.cos(th)-1)) + (2*Fo_r*(np.cos(th)-1)) + ((2*Fo_r*r_ph)*(np.cos(th_d)-1))/(r_mh+r_ph) - (2*Fo_r*r_mh*(1-np.cos(th_d))) /(r_mh+r_ph) )**2
                        
                        img = -1 *(CFL_z*np.sin(th) +2*Fo_r*r_ph*np.sin(th_d) /(r_mh+r_ph) + (2*Fo_r*r_mh*np.sin(th_d)) /(r_ph+r_mh) )**2
                        
                        G = abs(real + img )
                        
                        if  G <= 1:
                            # If the condition is satisfied, store the x and y values
                            G_values.append(G)
                            th_values.append(np.degrees(th))
                            th_d_values.append(th_d)
                            Fo_rvalues.append(Fo_r)
                            Fo_zvalues.append(Fo_z)
                            CFL_zvalues.append(CFL_z)

fig =plt.figure(figsize=(12, 12))
# Add a 3D scatter plot
ax = fig.add_subplot(111, projection='3d')
ax.scatter(Fo_rvalues,Fo_zvalues,CFL_zvalues, c='blue', marker='o')
plt.subplots_adjust(left=0.1, right=0.9, top=0.9, bottom=0.1)
# Add labels
ax.set_xlabel('Fo_r',fontsize=15)
ax.set_ylabel('Fo_z',fontsize=15)
ax.set_zlabel('CFL_z',fontsize=15)
plt.title("Region of Stability", fontsize=25)

plt.ion()

plt.show()
                            