#!/bin/bash
#Begin LSF Directives
#BSUB -W 1:00:00
#BSUB -nnodes 1

module load essl
#------ MPI ranks and OMP threads ------
NRANKS=6
ncore=7
export OMP_NUM_THREADS=$ncore
#------ end MPI ranks and OMP threads ------

input=0100w_631G.inp
  export GMSPATH=/path of GAMESS executable directory/
export USERSCR=./
export SCR=./
export JOB=JOB.$LSB_JOBID
export LOG=${input%.inp}.log
export OUTPUT=${JOB}.F06
cp $inp ${JOB}.F05

ulimit -s unlimited

export OMP_DEV_HEAPSIZE=2000000
export OMP_PROC_BIND=false

# setup environment for gamess
source $GMSPATH/gms-files.bash

#------ ------
jsrun -n $NRANKS -a 2 -c $ncore -d cyclic -b packed:$ncore -g 1 $GMSPATH/gamess.$VER.x >> $LOG

