
export PATH=~/../..//usr/local/gromacs/bin/:$PATH

data_dir="/home/student6/06.Struct_bioinf/hw4_2"

## по стопам https://www.swissparam.ch/SwissParam_gromacs_tutorial.html


cd $data_dir 
# gmx pdb2gmx -f protein.pdb -ff charmm27 -water tip3p -ignh -o conf.pdb -nochargegrp


## #include "ligand.itp" and  ligand 1 in  topol.top
## Merge the protein and ligand coordinates. Insert the ATOM lines from the ligand.pdb into the conf.pdb file, right after the line for the ion CAL. Atoms will be automatically renumbered in the next step. 

# gmx editconf -f conf.pdb -o boxed.pdb -c -d 1.2 -bt octahedron

# # genbox разбита на solvate и insert-molecules
## gmx genbox -cs -cp boxed.pdb -o solvated.pdb -p topol.top
# gmx solvate -cs -cp boxed.pdb -o solvated.pdb -p topol.top

## gmx insert-molecules boxed.pdb -o solvated.pdb -p topol.top



# init=step3_input
mini_prefix=step4.0_minimization
equi_prefix=step4.1_equilibration
prod_prefix=step5_production
prod_step=step5


# -n index.ndx


# # Minimization
# gmx grompp -f ${mini_prefix}.mdp -c solvated.pdb -r solvated.pdb -p topol.top -o ${mini_prefix}.tpr -maxwarn -1
# gmx mdrun -nt 16 -pin on -pinoffset 10 -v -deffnm ${mini_prefix}

# # # Equilibration
# gmx grompp -f ${equi_prefix}.mdp -c ${mini_prefix}.gro -r solvated.pdb -p topol.top -o ${equi_prefix}.tpr -maxwarn -1
# gmx mdrun -nt 16 -pin on -pinoffset 10 -v -deffnm ${equi_prefix}

# # # # Production
# gmx grompp -f ${prod_prefix}.mdp -c ${equi_prefix}.gro -p topol.top -o ${prod_prefix}.tpr -maxwarn -1
# gmx mdrun -nt 16 -pin on -pinoffset 10 -v -deffnm ${prod_prefix}
# # 


gmx trjconv -s ${prod_prefix}.tpr -f solvated.pdb -o compact.pdb -ur compact -pbc mol