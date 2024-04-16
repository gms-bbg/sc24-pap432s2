#!/bin/sh
#PBS -l select=1
#PBS -j oe
#PBS -l walltime=01:30:00

module load oneapi/release/2023.12.15.001
cd ${PBS_O_WORKDIR}

NNODES=`wc -l < $PBS_NODEFILE`
# n mpi ranks= n/2 compute processes + n/2 data servers for gamess
#------ MPI ranks and OMP threads ------
export RANKS_PER_NODE=24  # Number of MPI ranks per node
export OMP_NUM_THREADS=8
export OMP_DEV_HEAPSIZE=500000
export OMP_DISPLAY_ENV=T
export OMP_STACKSIZE=1G
#------ end MPI ranks and OMP threads ------


NRANKS=$(( NNODES * RANKS_PER_NODE ))

echo "NUM_OF_NODES=${NNODES}  TOTAL_NUM_RANKS=${NRANKS}  RANKS_PER_NODE=${RANKS_PER_NODE}"
# reduce MPI overhead
export MPIR_CVAR_ENABLE_GPU=0


input=0100w_631G.inp
  export GMSPATH=/path of GAMESS executable directory/

name=${input%.inp}
inp=${name}.inp
log=${name}.log
ulimit -s unlimited

export SCR=./
export USERSCR=./
export JOB=JOB.$PBS_JOBID
cp $inp ${JOB}.F05

export OUTPUT=${JOB}.F06

# setup environment for gamess
source $GMSPATH/gms-files.bash

# for cpu MPI/OMP
       mpiexec -n ${NRANKS} -ppn ${RANKS_PER_NODE}  \
    --cpu-bind verbose,depth -d ${OMP_NUM_THREADS} \
      $GMSPATH/gamess.00.x >& $log

