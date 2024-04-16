#!/bin/bash
#Begin LSF Directives
#BSUB -W 1:00:00
#BSUB -nnodes 1

module load essl

#------ MPI ranks for cpu MPI executions------
NRANKS=42
#------ end MPI ranks for cpu MPI executions------

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

#------ for cpu MPI execution ------
jsrun -n $NRANKS -a 2 -c 1 -d cyclic $GMSPATH/gamess.$VER.x >> $LOG
