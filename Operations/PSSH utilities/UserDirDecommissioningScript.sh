# decommisioning script to remove user dirs
# run from master node
# address list includes data nodes 1-8, edge nodes and masternodes 2,3
# need to install pssh to work
# sudo apt-get install pssh

pscp -O StrictHostKeyChecking=no -h /root/address_list.txt /root/USERLIST.txt /root/

pssh -O StrictHostKeyChecking=no -h /root/address_list.txt -t 15 -p 15 -i '
        DELUSERS=0;
        ls /home > /root/homedir.txt;

                while read LINE;
                        do
                                if grep -Fxq  $LINE USERLIST.txt
                                        then
                                                echo "Skipping $LINE"
                                        else
                                                echo "$LINE will be deleted"
                                                rm -r /home/$LINE
                                                let "DELUSERS++"
                                fi
                done < /root/homedir.txt

echo "$DELUSERS user dirs to be deleted";
rm /root/USERLIST.txt
rm /root/homedir.txt'

echo "ending...";

# sudo apt-get remove pssh
