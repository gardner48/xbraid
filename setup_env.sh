#!/bin/bash

if [ "$HOST" == "Sandcastle.llnl.gov" ]; then

    source ~/.bashrc

    module load gcc-9.2.0
    export CC=gcc

    module load openmpi-3.1.5
    export MPICC=mpicc
    export MPICXX=mpicxx

    module load hypre-2.18.2-int32
    export HYPRE_DIR=${HYPRE_ROOT}
    export HYPRE_LIBRARY_FILE=libHYPRE.a

elif [ "$HOST" == "quartz" ]; then

    module load gcc/8.1.0
    export CC=gcc
    export CXX=g++
    export FC=gfortran

    module load mvapich2/2.3
    export MPICC=mpicc
    export MPICXX=mpicxx
    export MPIFC=mpifort

    export CFLAGS='-g -O2'
    export CXXFLAGS='-g -O2'
    export FORTFLAGS='-g -O2'

else

    source ~/.bashrc
    loadspack local

    module load gcc-9.3.0
    export CC=gcc

    module load openmpi-3.1.5
    export MPICC=mpicc
    export MPICXX=mpicxx

    module load hypre-2.18.2-int32
    export HYPRE_DIR=${HYPRE_ROOT}
    export HYPRE_LIBRARY_FILE=libHYPRE.so

fi

export XBRAID_ROOT=${PWD}/braid
