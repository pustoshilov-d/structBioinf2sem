#!/bin/bash

wget ftp://ftp.gromacs.org/gromacs/gromacs-2021.1.tar.gz
tar -xzvf gromacs-2021.1.tar.gz
cd gromacs-2021.1
rm -rf build
mkdir -p $HOME/bin/
mkdir build
cd build
module load cuda/10.2 load gcc/7.4.0
cmake3 .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=OFF -DGMX_GPU=CUDA \
-DCMAKE_INSTALL_PREFIX=$HOME/bin/gromacs_nompi -DBUILD_SHARED_LIBS=off -DGMXAPI=off \
-DGMX_MPI=off -DGMX_DOUBLE=off

make -j4
#make check
make install -j4
#source /usr/local/gromacs/bin/GMXRC
