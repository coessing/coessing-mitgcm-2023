# Instructions for getting, building, and running the
# Anyanui Estuary MITgcm configuration

# Southwest Corner has coordinates
# 5.77472222 N
# 0.69719017 E

# Northeast corner has coordinates
# 5.78388889 N
# 0.71027778 E

# Domain size: 25x18
# DeltaY = 5.09259444e-04
# DeltaX = 5.23504400e-04

# 1. Get MItgcm and this repository
  git clone -–depth 1 git@github.com:MITgcm/MITgcm.git
  git clone git@github.com:coessing/coessing-mitgcm-2023.git

# 2. Build executable
  cd MITgcm
  mkdir build
  cd build
  ../tools/genmake2 -mo ../../coessing-mitgcm-2023/Estuary/code
  make depend
  make -j

# 3. Run a 1-day test experiment
  cd ..
  mkdir run
  cd run
  ln -sf ../build/mitgcmuv .
  cp ../../coessing-mitgcm-2023/Estuary/input/* .
  ./mitgcmuv > output.txt
