#!/usr/bin/env bash
# file:   setup_debian.sh
# author: Jess Robertson
# date:   August 2015
#
# Sets up a Debian VM from scratch. There are many init scripts, but this one is mine.

## INSTALL SYSTEM LIBS
# Somewhere to stick local packages
export LOCAL="${HOME}/.local"

# Install packages using apt-get
sudo apt-get update
sudo apt-get install git tig vim screen bash-completion bzip2 ruby

## INSTALL DOCKER
# Add jessie-backports to apt so we can get docker
sudo sh -c "echo deb http://cloudfront.debian.net/debian jessie-backports main >> /etc/apt/sources.list"
sudo apt-get update
sudo apt-get install docker.io

# Add current user to docker group for non-root access
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart

## INSTALL CONDA
# Set up where we're going to stick it
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
${CONDA_HOME}/bin/conda install --yes conda==3.10.1
export PATH=${CONDA_HOME}/bin:$PATH

# Configure conda to use Jess' binstar channel
conda config --set always_yes yes --set changeps1 no
conda config --add channels jesserobertson
conda update -q conda
conda info

## INSTALL FLEET and ETCHD
# First of all, lets get source from Github. 
git clone https://github.com/coreos/fleet.git
git clone https://github.com/coreos/etcd.git

# Make sure we have golang avilable
sudo apt-get install golang

# Build and install etcd
cd etcd
./build && ./test
cp bin/* ${LOCAL}/bin/.
cd ..

# Build and install fleet
cd fleet
./build && ./test
cp bin/* ${LOCAL}/bin/.
cd ..
