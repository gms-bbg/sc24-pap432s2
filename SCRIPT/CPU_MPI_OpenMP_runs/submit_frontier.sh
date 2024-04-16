#!/bin/bash
#SBATCH -N 1
#SBATCH -t 1:00:00

#------ MPI ranks and OMP threads ------
export RANKS_PER_NODE=16 # Number of MPI ranks per node
export OMP_NUM_THREADS=4
#------ end MPI ranks and OMP threads ------

NRANKS=$(( SLURM_NNODES * RANKS_PER_NODE ))

input=0100w_631G.inp
  export GMSPATH=/path of GAMESS executable directory/

name=${input%.inp}
inp=${name}.inp
log=${name}.log
ulimit -s unlimited
cp $inp ${JOB}.F05

export SCR=./
export USERSCR=./

# setup environment for gamess
source $GMSPATH/gms-files.bash

# for cpu runs
 srun -n ${NRANKS} --output $JOB.log $GMSPATH/gamess.00.x

