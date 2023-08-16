# Instructions for building and running Gulf of Guinea regional simulation

# 1. Get this repository
  git clone git@github.com:coessing/coessing-mitgcm-2023.git

# 2. Get darwin3
# darwin3 is a version of MITgcm that contains the Darwin package
# for ECCO-Darwin, we use an older version of darwin3 (git tag 24885b71)
# which will have outdated build_options files
# a version darwin3 24885b71 with updated buil_doptions files is here:
# https://nasa-ext.box.com/s/1vwbdy0b18g0wf0cpwn45ss72n36z0pv

# 3. Check that you can run parallel MITgcm on your platform
  cd darwin3/verification
  ./testreport -mpi -t natl_box

# 4. Build executable
  cd ..
  mkdir build
  cd build
  ../tools/genmake2 -mo ../../coessing-mitgcm-2023/GulfGuinea/v05/code -mpi

# 5. Run 45-day simulation (January 16 1992 to March 1, 1992)
  cd ..
  mkdir run
  cd run
  ln -sf ../build/mitgcmuv .
# Get forcing and configuration files from
# https://nasa-ext.box.com/s/p6s9uqg4dnl31ws1ofvf3wousm9pjqvi
# and copy all files contained in run_template in run directory
  mkdir diags diags/daily diags/monthly
  cp ../../coessing-mitgcm-2023/GulfGuinea/v05/input/* .
  mpirun -np 6 ./mitgcmuv
