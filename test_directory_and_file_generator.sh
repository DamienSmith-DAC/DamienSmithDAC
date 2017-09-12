#!/bin/bash
# Intended only for use when you need to create large volumes of directories / files for test purposes
# Used originally for testing data orchestration jobs

for i in {1..5}
do
   mkdir test${i}
   for j in {1..5}
   do
      echo content${j} > test${i}/test${j}.csv
   done
done

# You may need to change the ownership of the files that have been created for test purposes if done from a different user
# chown -R centos:centos ./*
