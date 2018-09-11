#!/bin/bash

export SPARK_MAJOR_VERSION=2
export SPARK_HOME=/usr/hdp/current/spark2-client
export HADOOP_CONF_HOME=/etc/hadoop/conf

export PATH="${SPARK_HOME}/bin:${PATH}"
