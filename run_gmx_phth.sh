#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --partition=GTX780
#SBATCH --mail-user="FILL ME"
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --job-name=gpu-practice-bioinf
#SBATCH --comment="homework for structural bioinformatics"

module load cuda/10.2 gcc/7.4.0
source $HOME/bin/gromacs_nompi/bin/GMXRC
init=step3_input
mini_prefix=step4.0_minimization
equi_prefix=step4.1_equilibration
prod_prefix=step5_production
prod_step=step5


# Minimization
gmx grompp -f ${mini_prefix}.mdp -o ${mini_prefix}.tpr -c ${init}.gro -r ${init}.gro -p topol.top -n index.ndx -maxwarn -1
gmx mdrun -nt 8 -v -deffnm ${mini_prefix}

# Equilibration
gmx grompp -f ${equi_prefix}.mdp -o ${equi_prefix}.tpr -c ${mini_prefix}.gro -r ${init}.gro -p topol.top -n index.ndx -maxwarn -1
gmx mdrun -nt 8 -v -deffnm ${equi_prefix}

# Production
gmx grompp -f ${prod_prefix}.mdp -o ${prod_prefix}.tpr -c ${equi_prefix}.gro -p topol.top -n index.ndx
gmx mdrun -nt 8 -v -deffnm ${prod_prefix}


