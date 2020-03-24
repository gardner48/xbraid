#!/bin/bash

loadspack sunenv

spack load gcc@9.2.0
spack load openmpi%gcc@9.2.0

spack load hypre%gcc@9.2.0~int64
export HYPRE_DIR="$(spack location -i hypre%gcc@9.2.0~int64)"
export HYPRE_LIBRARY_FILE=libHYPRE.so

export CC=gcc
export MPICC=mpicc
export MPICXX=mpicxx
