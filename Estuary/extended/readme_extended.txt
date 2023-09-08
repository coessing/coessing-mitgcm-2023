# Instructions for getting, building, and running the
# Anyanui Estuary MITgcm configuration

# Southwest Corner has coordinates
# 5.77444444 N
# 0.69805556 E

# Northeast corner has coordinates
# 5.79277778 N
# 0.72222222 E

# Domain size: 882x690
# DeltaY = 2.6570057971014295e-05
# DeltaX = 2.739984126984128e-05

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
  mpirun -np 6 --use-hwthread-cpus ./mitgcmuv > output.txt
