# -*- coding: utf-8 -*-
"""
Created on Mon Jan  6 02:07:26 2025

@author: lebia
"""

import numpy as np
import matplotlib.pyplot as plt

#################### User Defined Inputs###############
#Dimensions
T_r = 0.2          # Total Radius in meters
T_z = 1            # Total length in meters
T_t = 5          # Total analysis time in seconds
nr = 150         # Number of spatial volumes in r direction
nz = 400           # Number of spatial volumes in z direction
# Fluid properties
k = 0.6          # Thermal conductivity of water (W/m°C or J/s·m·°C)
rho_d = 998.2        # Density of water (kg/m³)
cp_h = 4182        # Specific heat capacity (J/kg·°C)
# Initial conditions
T_in = 293.15       # Inlet temperature (°C)
u_in = 5           # Inlet velocity (m/s)
phi_flux =1e6      # Flux at the wall boundary condition (W/m²)
CFL = 0.4        # Stability condition (Courant number)

########################################################################
a = k / (rho_d * cp_h)  # Thermal diffusivity
del_r = T_r / nr   # Radial step size
del_z = T_z / nz   # Axial step size
del_t = CFL * del_z / u_in  # Time step size
n_t = int(T_t / del_t)  # Total number of time steps

# Flux and other parameters
F_r = (a * del_t) / (del_r ** 2)
F_z = (a * del_t) / (del_z ** 2)

# Initialize temperature array (nz x nr x n_t)
T = np.zeros((nz, nr, n_t))
T[:, :, 0] = 373.15  # Set initial temperature

# Main time-stepping loop
skip=0
for n in range(1, n_t):
   # print(n)
   
    for i in range(nz):
        r = 0  # Reset radius for each radial node
        for j in range(nr):
            rp = r + del_r
            uz = 2 * u_in * (1 - (r / T_r) ** 2)  # Velocity profile
            vij = (np.pi * (rp + r) * del_r * del_z) / 2

            # Control volumes
            Ae = (np.pi / 2) * (rp + r) * del_r
            Aw = (np.pi / 2) * (rp + r) * del_r
            An = np.pi * rp * del_z
            As = np.pi * r * del_z

            # Region-specific temperature updates
            if i == 0 and j == nr - 1:  # Region 1
                T[i, j, n] = T[i, j, n - 1] + (del_t / vij) * (
                    (phi_flux * An) / (rho_d * cp_h) - (a * As * (T[i, j, n - 1] - T[i, j - 1, n - 1]) / del_r)
                    + (a * Ae * (T[i + 1, j, n - 1] - T[i, j, n - 1]) / del_z)
                    - (2 * a * Aw * (T[i, j, n - 1] - T_in) / del_z)
                    - ((uz * Ae * T[i, j, n - 1]) - (uz * Aw * T_in))
                )
            elif i == 0 and j == 0:  # Region 3
                T[i, j, n] = T[i, j, n - 1] + (del_t / vij) * (
                    (a * An * (T[i, j + 1, n - 1] - T[i, j, n - 1]) / del_r)
                    + (a * Ae * (T[i + 1, j, n - 1] - T[i, j, n - 1]) / del_z)
                    - (2 * a * Aw * (T[i, j, n - 1] - T_in) / del_z)
                    - ((uz * Ae * T[i, j, n - 1]) - (uz * Aw * T_in))
                )
            elif i == nz - 1 and j == nr - 1:  # Region 7
                T[i, j, n] = T[i, j, n - 1] + (del_t / vij) * (
                    (phi_flux * An) / (rho_d * cp_h) - (a * As * (T[i, j, n - 1] - T[i, j - 1, n - 1]) / del_r)
                    - (a * Aw * (T[i, j, n - 1] - T[i - 1, j, n - 1]) / del_z)
                    - ((uz * Ae * T[i, j, n - 1]) - (uz * Aw * T[i - 1, j, n - 1]))
                )
            elif i == nz - 1 and j == 0:  # Region 5
                T[i, j, n] = T[i, j, n - 1] + (del_t / vij) * (
                    (a * An * (T[i, j + 1, n - 1] - T[i, j, n - 1]) / del_r)
                    - (a * Aw * (T[i, j, n - 1] - T[i - 1, j, n - 1]) / del_z)
                    - ((uz * Ae * T[i, j, n - 1]) - (uz * Aw * T[i - 1, j, n - 1]))
                )
            elif i == 0 and j != 0 and j != nr - 1:  # Region 2
                T[i, j, n] = T[i, j, n - 1] + (del_t / vij) * (
                    (a * An * (T[i, j + 1, n - 1] - T[i, j, n - 1]) / del_r)
                    - (a * As * (T[i, j, n - 1] - T[i, j - 1, n - 1]) / del_r)
                    + (a * Ae * (T[i + 1, j, n - 1] - T[i, j, n - 1]) / del_z)
                    - (2 * a * Aw * (T[i, j, n - 1] - T_in) / del_z)
                    - ((uz * Ae * T[i, j, n - 1]) - (uz * Aw * T_in))
                )
            elif j == 0 and i != 0 and i != nz - 1:  # Region 4
                T[i, j, n] = T[i, j, n - 1] + (del_t / vij) * (
                    (a * An * (T[i, j + 1, n - 1] - T[i, j, n - 1]) / del_r)
                    + (a * Ae * (T[i + 1, j, n - 1] - T[i, j, n - 1]) / del_z)
                    - (a * Aw * (T[i, j, n - 1] - T[i - 1, j, n - 1]) / del_z)
                    - ((uz * Ae * T[i, j, n - 1]) - (uz * Aw * T[i - 1, j, n - 1]))
                )
            elif i == nz - 1 and j != 0 and j != nr - 1:  # Region 6
                T[i, j, n] = T[i, j, n - 1] + (del_t / vij) * (
                    (a * An * (T[i, j + 1, n - 1] - T[i, j, n - 1]) / del_r)
                    - (a * As * (T[i, j, n - 1] - T[i, j - 1, n - 1]) / del_r)
                    - (a * Aw * (T[i, j, n - 1] - T[i - 1, j, n - 1]) / del_z)
                    - ((uz * Ae * T[i, j, n - 1]) - (uz * Aw * T[i - 1, j, n - 1]))
                )
            elif j == nr - 1 and i != 0 and i != nz - 1:  # Region 8
                T[i, j, n] = T[i, j, n - 1] + (del_t / vij) * (
                    (phi_flux * An) / (rho_d * cp_h) - (a * As * (T[i, j, n - 1] - T[i, j - 1, n - 1]) / del_r)
                    + (a * Ae * (T[i + 1, j, n - 1] - T[i, j, n - 1]) / del_z)
                    - (a * Aw * (T[i, j, n - 1] - T[i - 1, j, n - 1]) / del_z)
                    - ((uz * Ae * T[i, j, n - 1]) - (uz * Aw * T[i - 1, j, n - 1]))
                )
            else:  # Region 9
                T[i, j, n] = T[i, j, n - 1] + (del_t / vij) * (
                    (a * An * (T[i, j + 1, n - 1] - T[i, j, n - 1]) / del_r)
                    - (a * As * (T[i, j, n - 1] - T[i, j - 1, n - 1]) / del_r)
                    + (a * Ae * (T[i + 1, j, n - 1] - T[i, j, n - 1]) / del_z)
                    - (a * Aw * (T[i, j, n - 1] - T[i - 1, j, n - 1]) / del_z)
                    - ((uz * Ae * T[i, j, n - 1]) - (uz * Aw * T[i - 1, j, n - 1]))
                )

            r += del_r
           
    skip+=1
            
            # Visualization

    if skip%40 ==0:
        z_values = np.linspace(0, T_z, nz)
        r_values = np.linspace(-T_r, T_r, 2 * nr)
        temperature_data = T[:, :, n]  # Final time step
        #print(temperature_data)
        #print("myru")
        temperature_data_full = np.hstack((temperature_data[:, ::-1], temperature_data))
        R, Z = np.meshgrid(r_values, z_values, indexing='ij')
        plt.figure(figsize=(12, 8))
        contour = plt.contourf(Z, R, temperature_data_full.T, levels=50, cmap='jet')
        
        
            # Represent walls using lines
        # Bottom wall
        plt.plot([0, T_z], [-T_r-(0.01), -T_r-(0.01)], color='#444444', linewidth=5, label="Bottom Wall")
        # Top wall
        plt.plot([0, T_z], [T_r+(0.01), T_r+(0.01)], color='#444444', linewidth=5, label="Top Wall")
        # Left wall
        plt.plot([(-0.01), (-del_z)], [-T_r-(0.01), T_r+(0.01)], color='lime',linestyle='--', linewidth=2, label="Inlet")
        # Right wall
        plt.plot([T_z+(0.01), T_z+(0.01)], [-T_r-(0.01), T_r+(0.01) ], color='magenta',linestyle='--', linewidth=2, label="Outlet")
    
        # Set axis limits and aspect ratio
        plt.xlim(-0.1, T_z+0.1 )
        plt.ylim(-0.1-T_r, T_r + 0.1)
        plt.gca().set_aspect('equal')  # Equal scaling for x and y
    
        plt.colorbar(contour, label="Temperature (°C)")
        plt.xlabel('Axial Length (m)')
        plt.ylabel('Radial Distance (m)')
        plt.title(f'Temperature Distribution at Time {round((n * del_t), 4)} s')
        plt.legend()
        plt.legend(loc='upper center',bbox_to_anchor=(0.5, 1),ncol=2, borderaxespad=0.2, frameon=True)
        #plt.legend(loc='upper right', bbox_to_anchor=(1, 1), borderaxespad=0, frameon=True)
        #plt.legend(loc='upper right', bbox_to_anchor=(1, 1), borderaxespad=0)
        
        plt.show()
       


        



