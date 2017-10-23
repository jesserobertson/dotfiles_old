#!/usr/bin/env bash

## INSTALL CONDA
# Set up where we're going to stick it
# Somewhere to stick local packages
export LOCAL="${HOME}/.local"
export CONDA_URL="https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh"
export CONDA_HOME="${LOCAL}/conda"
conda_exe="${CONDA_HOME}/bin/conda"

# Set up paths
# Note that conda spews if CONDA_HOME already exists
mkdir -p ${LOCAL}/bin

# Actually do install
rm -rf ${CONDA_HOME}
wget --quiet ${CONDA_URL} -O miniconda.sh
/bin/bash miniconda.sh -b -p ${CONDA_HOME}
rm miniconda.sh
${conda_exe} install --yes conda
export PATH=${CONDA_HOME}/bin:$PATH

# Configure config options
${conda_exe} config --set always_yes yes --set changeps1 no
${conda_exe} update -q conda

# Configure root environment using environment file
${conda_exe} env update --name root --file root-environment.yml
${conda_exe} info
