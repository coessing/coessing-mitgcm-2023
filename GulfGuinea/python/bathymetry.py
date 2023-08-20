import numpy as np
import matplotlib.pyplot as plt
import os

# Specify directory location of global cutout
dir1 = '/home/emmanuel/coessing2023/GulfGuinea/GlobalCutout/'

# Specify directory location for saving figures
dir2 = '/home/emmanuel/coessing2023/GulfGuinea/GlobalCutout/figs_python/'

# Grid dimensions
nx = 69
ny = 66
nz = 50

# Read binary data
XC = np.fromfile(dir1 + 'grid/XC_69x66', dtype='>f4').reshape((ny, nx))
YC = np.fromfile(dir1 + 'grid/YC_69x66', dtype='>f4').reshape((ny, nx))
Depth = np.fromfile(dir1 + 'grid/Depth_69x66', dtype='>f4').reshape((ny, nx))
Depth[Depth == 0] = np.nan

xm, xn = XC.max(), XC.min()
ym, yn = YC.max(), YC.min()

#Define coast of Ghana
ix = np.arange(18,33)
iy = np.arange(55,65)

x = [XC[0,ix[0]],XC[0,ix[-1]],XC[0,ix[-1]],XC[0,ix[0]],XC[0,ix[0]]]
y = [YC[iy[0],0],YC[iy[0],0],YC[iy[-1],0],YC[iy[-1],0],YC[iy[0],0]]

# Plot bathymetry
fig, ax = plt.subplots(figsize=(10,7))
dbt = ax.imshow(-Depth, origin='lower', cmap='jet', extent=[xn, xm, yn, ym])
plt.colorbar(dbt,label='Depth (m)')
# add box to map
ax.plot(x,y, c='k')
plt.xlabel('Longitude East ($\degree$)')
plt.ylabel('Latitude North ($\degree$)')
plt.savefig(os.path.join(dir2, 'bathymetry.jpg'))
plt.show()
