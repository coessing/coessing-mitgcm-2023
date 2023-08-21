import numpy as np
import matplotlib.pyplot as plt

# This assumes you have lists DTE, SST and CHL
# containing dates, SST mean values and CHL mean values of Ghana coastal box
# If not please use the GulfGuineaCutout_plot notebook.

# Create the plot
fig, ax1 = plt.subplots(figsize=(10,7))

# Plot the first dataset using the left y-axis
ax1.plot(DTE, SST, color='tab:blue', label='SST')
ax1.set_xlabel('Date')
ax1.set_ylabel('Sea Surface Temperature ($\degree C)', color='tab:blue')
ax1.tick_params(axis='y', labelcolor='tab:blue')
ax1.set_ylim(24, 31)
ax1.set_xlim(DTE[0],DTE[-1])

# Create a twin y-axis on the right side for the second dataset
ax2 = ax1.twinx()
ax2.plot(DTE, CHL, color='tab:orange', label='CHL')
ax2.set_ylabel('Total Chlorophyll ($mg/m^2$)', color='tab:orange')
ax2.tick_params(axis='y', labelcolor='tab:orange')
ax2.set_ylim(10, 60)
ax1.set_xticks(DTE[::4])

# Add a common title and legend
fig.suptitle('SST and Chl time series in Ghana coastal box')
#fig.legend(loc='upper left', bbox_to_anchor=(0.15, 0.9))
ax1.grid(True)

# Show the plot
plt.savefig(os.path.join(dir2, f'SST_CHL_TimeSeries.jpg'))
plt.show()