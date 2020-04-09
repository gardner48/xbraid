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
