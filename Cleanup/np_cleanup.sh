#!/bin/bash

# Script used to clean HDFS and edge nodes of test and unused user's directory 



echo 'Beginning...'


# Current State
echo 'hdfs dfs -ls /user'
hdfs dfs -ls /user

echo 'ssh -n np-edge.dac.local "ls -al /home"'
ssh -n np-edge.dac.local "ls -al /home"


# Delete Directories 
USERS=( chrontest createtestuser2 createtestuser6 createtestusera createtestuserc createtestuserd createtestuserf createtestuserg createtestuserh createusertest crontest2 npctu1 npctu2 nptintin np_allenb )

for USER in ${USERS[@]}; do

	echo ${USER}
	hdfs dfs -rmdir /user/${USER}
	ssh -n np-edge.dac.local "rmdir --ignore-fail-on-non-empty /home/${USER}"
	#ssh -n .dac.local "rmdir /home/${USER}"
	#ssh -n .dac.local "rmdir /home/${USER}"
	#mysql -u root -p -e "${USER}"

done

if [ $? -ne 0 ]; then
        exit
fi

# New State

echo 'hdfs dfs -ls /user'
hdfs dfs -ls /user

echo 'ssh -n np-edge.dac.local "ls -al /home"'
ssh -n np-edge.dac.local "ls -al /home"

echo '...script finished'