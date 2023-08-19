import numpy as np
import matplotlib.pyplot as plt

# make bathymetry data of size 18x25
bath = np.zeros((18,25))
bath[0,-5:-3]=7.5
bath[1,2:5]=10
bath[1,-6:-4]=7.5
bath[2,1:5]=10
bath[2,-6:]=8
bath[3,2:6]=10
bath[3,-7:-3]=8
bath[4,2:7]=10
bath[4,-8:-4]=8
bath[5,3:7]=9.5
bath[5,-8:-4]=8
bath[6,4:8]=9.5
bath[6,-9:-2]=8.5
bath[7,4:9]=9.5
bath[7,-9:-1]=8.5
bath[8,5:9]=9.5
bath[8,-3:]=8.5
bath[8,-10:-4]=8.5
bath[-2,10:13]=9
bath[-3,8:14]=9
bath[-4,7:15]=9
bath[-5,7:16]=9
bath[-6,6:17]=9
bath[-7,6:18]=9
bath[-8,5:11]=9.5
bath[-8,-11:-7]=8.5
bath[-9,5:10]=9.5
bath[-9,-2:]=8.5
bath[-9,-10:-6]=8.5

# view plot of bathymetry
plt.imshow(bath, origin='lower')

# convert to binary as a single-precision (float32) 
# with big-endian byte ordering
bath.astype('>f4').tofile('depth_25x18.bin')
