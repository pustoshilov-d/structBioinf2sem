work_dir="/home/student6/06.Struct_bioinf"
export PATH=~/../..//usr/local/gromacs/bin/:$PATH

# ftp://ftp.gromacs.org/gromacs/gromacs-2021.2.tar.gz

# wget ftp://ftp.gromacs.org/gromacs/gromacs-2021.2.tar.gz


# tar xfz gromacs-2021.2.tar.gz
# cd $work_dir/gromacs-2021.2
# mkdir build
# cd build
# cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON
# make
# make check
# sudo make install

# sudo ln -s $work_dir/gromacs-2021.2
# source /usr/local/gromacs/bin/GMXRC

# после обработки charmom
# tar -xzvf charmm-gui.tgz

# prodaction mdp - протокол расчёта

cd $work_dir/charmm-gui-2380092862/gromacs
init=step3_input
mini_prefix=step4.0_minimization
equi_prefix=step4.1_equilibration
prod_prefix=step5_production
prod_step=step5


# Minimization
gmx grompp -f ${mini_prefix}.mdp -o ${mini_prefix}.tpr -c ${init}.gro -r ${init}.gro -p topol.top -n index.ndx -maxwarn -1
gmx mdrun -nt 8 -v -deffnm ${mini_prefix}

# # Equilibration
gmx grompp -f ${equi_prefix}.mdp -o ${equi_prefix}.tpr -c ${mini_prefix}.gro -r ${init}.gro -p topol.top -n index.ndx -maxwarn -1
gmx mdrun -nt 8 -v -deffnm ${equi_prefix}

# # Production
gmx grompp -f ${prod_prefix}.mdp -o ${prod_prefix}.tpr -c ${equi_prefix}.gro -p topol.top -n index.ndx
gmx mdrun -nt 8 -v -deffnm ${prod_prefix}
