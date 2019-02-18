#!/bin/bash

# Installs Python 2 packages (using pip) and any non python dependencies (using yum)

#### CONSTANTS ####

MPICXX_EXE=/usr/lib64/openmpi/bin

#### MAIN ####

# Ensures pip is installed
yum install -y python2-pip
# Required by many packages
yum install -y gcc
yum install -y gcc-c++
# Required by plotly
yum install -y tkinter
# Required by horovod
yum install -y openmpi openmpi-devel

pip install -U pip
pip install -U setuptools

# Need mpicxx in PATH when installing the horovod package
PATH="${PATH}:${MPICXX_EXE}"

PIP_PACKAGES="request dbutils scipy numpy matplotlib pandas statsmodels scikit-learn theano tensorflow keras plotly seaborn horovod pyocr pillow scrapy dialogflow apiai h5py spark-sklearn tensorflowonspark xlrd datarobot docx-mailmerge faker pyspark "

IFS=" "

for package in $PIP_PACKAGES; do
	echo "Installing pip package ${package}"
	pip install --ignore-installed "${package}"
done

unset IFS
