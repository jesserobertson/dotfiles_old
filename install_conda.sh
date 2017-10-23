#!/usr/bin/env bash

## INSTALL CONDA
# Set up where we're going to stick it
# Somewhere to stick local packages
export LOCAL="${HOME}/.local"
export CONDA_URL="https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh"
export CONDA_HOME="${LOCAL}/conda"

# Set up paths
# Note that conda spews if CONDA_HOME already exists
mkdir -p ${LOCAL}/bin

# Actually do install
rm -rf ${CONDA_HOME}
wget --quiet ${CONDA_URL} -O miniconda.sh
/bin/bash miniconda.sh -b -p ${CONDA_HOME}
rm miniconda.sh
${CONDA_HOME}/bin/conda install --yes conda
export PATH=${CONDA_HOME}/bin:$PATH

# Configure conda to use Jess' binstar channel
conda config --set always_yes yes --set changeps1 no
conda config --add channels jesserobertson
conda update -q conda
conda info
