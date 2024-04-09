# Sunspot/Aurora
module load oneapi/release/2023.12.15.001

# Crusher/Frontier
module load craype-accel-amd-gfx90a
module load rocm/5.4.0
module load PrgEnv-cray
module load cce/15.0.1
module load cray-mpich/8.1.23
module load craype/2.7.19

# Perlmutter: NVHPC
module load craype-x86-milan
module load craype-accel-nvidia80
module load PrgEnv-nvidia
module load nvidia/22.7
module load cudatoolkit

# Perlmutter: CCE
module load craype-x86-milan
module load craype-accel-nvidia80
module load PrgEnv-cray
module load cudatoolkit
module load cce/15.0.1

# Summit: XLF
module load cuda
module unload darshan-runtime
module load xl
module load essl
module load netlib-lapack/3.9.1

# Summit: NVHPC
module load cuda
module unload darshan-runtime
module load essl
module load netlib-lapack/3.9.1
module load nvhpc/22.5
