import numpy as np
import matplotlib.pyplot as plt
from datetime import datetime
from dateutil.relativedelta import relativedelta
import os

# Specify directory location of global cutout
dir1 = '/home/emmanuel/coessing2023/GulfGuinea/GlobalCutout/'

# Specify directory location for saving figures
dir2 = '/home/emmanuel/coessing2023/GulfGuinea/GlobalCutout/figs_python/'

os.makedirs(os.path.join(dir2, 'SST'), exist_ok=True)
os.makedirs(os.path.join(dir2, 'Chl'), exist_ok=True)

# Grid dimensions
nx = 69
ny = 66
nz = 50
nt = 36

# Read binary data
XC = np.fromfile(dir1 + 'grid/XC_69x66', dtype='>f4').reshape((ny, nx))
YC = np.fromfile(dir1 + 'grid/YC_69x66', dtype='>f4').reshape((ny, nx))
RF = np.fromfile(dir1 + 'grid/RF.data', dtype='>f4')
thk = abs(np.diff(RF))

xm, xn = XC.max(), XC.min()
ym, yn = YC.max(), YC.min()

c_date = datetime(1996, 1, 1)

#Define coast of Ghana
ix = np.arange(18,33)
iy = np.arange(55,65)

x = [XC[0,ix[0]],XC[0,ix[-1]],XC[0,ix[-1]],XC[0,ix[0]],XC[0,ix[0]]]
y = [YC[iy[0],0],YC[iy[0],0],YC[iy[-1],0],YC[iy[-1],0],YC[iy[0],0]]

# Iterate through each month
for mo in range(1,nt + 1):
    dte_str = c_date.strftime('%Y%m%dT%H%M%S')

    # Generate monthly-mean Chl figure
    fld = np.zeros((ny,nx))
    for chl in range(1, 6):
        fnm = dir1 + f'Chl{chl}/Chl{chl}_69x66x50.{dte_str}'
        tmp = np.fromfile(fnm, dtype='>f4').reshape(nz, ny, nx)
        for k in range(nz):
            fld = fld + thk[k]*tmp[k,:,:]
    fld[fld == 0] = np.nan
    
    # plot monthly-mean depth-integrated total Chlorophyl
    plt.clf()
    fig, ax = plt.subplots(figsize=(10,7))
    ch = ax.imshow(fld, origin='lower', cmap='turbo', extent=[xn, xm, yn, ym])
    plt.colorbar(ch,label='Total Chlorophyll ($mg/m^2$)')
    plt.plot(x,y, c='k')
    ch.set_clim(0, 80)
    m = c_date.strftime('%b %Y')
    plt.title(f'Total Chlorophyll ($mg/m^2$) on  {m}')
    plt.xlabel('Longitude East ($\degree$)')
    plt.ylabel('Latitude North ($\degree$)')
    plt.savefig(os.path.join(dir2, f'Chl/month{mo:02}.jpg'))
    plt.close()

    c_date = c_date + relativedelta(months=1)

# Convert frames to movie using ffmpeg for Chl
os.system(f'ffmpeg -r 5 -pattern_type glob -i "{dir2}Chl/month*.jpg" -vcodec libx264 -vf "scale=800:-1" -crf 25 -pix_fmt yuv420p {dir2}Chl.mp4')
