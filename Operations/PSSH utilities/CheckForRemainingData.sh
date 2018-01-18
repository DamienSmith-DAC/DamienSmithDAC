# Checks what is in the remaining folders in /home on each node listed in address_list.txt
# Saves this output to remainingdata.txt

pssh -O StrictHostKeyChecking=no -h /root/address_list.txt -t 15 -p 15 -i '
        ls /home > /root/homedir.txt;

                while read LINE;
                        do
                                find "/home/$LINE" -type f -exec echo Found file {} \;
                        done < /root/homedir.txt' > remainingdata.txt
