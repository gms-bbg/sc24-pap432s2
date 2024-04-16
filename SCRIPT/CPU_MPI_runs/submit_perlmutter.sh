#!/bin/bash
#SBATCH -N 1
#SBATCH -C gpu # cpu for cpu runs
#SBATCH -t 1:00:00

#------ MPI ranks and OMP threads for cpu MPI executions------
export RANKS_PER_NODE=64  
#------ end MPI ranks and OMP threads for cpu MPI executions------

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
