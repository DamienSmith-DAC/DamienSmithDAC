#!/bin/bash

# Script used to clean HDFS and edge nodes of test and unused user's directory 



echo 'Beginning...'

# Delete Directories 
USERS=( createtestuser12 createtestuser13 createtestuser14 createtestuser15 createtestuser16 createtestuser17 createtestuser18 createtestuser19 createtestuser20 createtestuser21 createtestuser3 createtestuserB createtestuserE testusertest )

for USER in ${USERS[@]}; do

	echo ${USER}
	hdfs dfs -rmdir /user/${USER}
	ssh -n zeppelin-edge-1.dac.local "cd /home; rm -rf ${USER};"
	ssh -n rstudio-edge-1.dac.local "cd /home; rm -rf ${USER};"
	ssh -n spyder-edge-1.dac.local "cd /home; rm -rf ${USER};"
	#mysql -u root -p -e "${USER}"

done

if [ $? -ne 0 ]; then
        exit
fi

echo '...script finished'
