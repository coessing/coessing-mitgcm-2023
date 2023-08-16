import numpy as np
import matplotlib.pyplot as plt

# Specify location of global cutout
pin = '/home/emmanuel/coessing/GulfGuinea/GlobalCutout/'

# Grid dimensions
nx = 69
ny = 66
nz = 50

# Read binary data
XC = np.fromfile(pin + 'grid/XC_69x66', dtype='>f4').reshape((ny, nx))
YC = np.fromfile(pin + 'grid/YC_69x66', dtype='>f4').reshape((ny, nx))
Depth = np.fromfile(pin + 'grid/Depth_69x66', dtype='>f4').reshape((ny, nx))
Depth[Depth == 0] = np.nan

# Plot bathymetry
plt.imshow(-Depth, origin='lower', cmap='viridis')
plt.colorbar(label='Depth (m)')
plt.title('Model bathymetry (m)')
plt.xlabel('Longitude East ($\degree$)')
plt.ylabel('Latitude North ($\degree$)')
plt.show()
