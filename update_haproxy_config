#!/bin/bash
#execute from p-dachaproxy-21

#SET GITHUB VARIABLES
GIT_OWNER="DFSI-DAC"
GIT_REPO="Platform"
GIT_PATH="haproxy.cfg"
GIT_FILE="https://api.github.com/repos/$GIT_OWNER/$GIT_REPO/contents/$GIT_PATH"

#Backup existing haproxy.cfg on both HAPROXY servers
cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.`date +%Y%m%d` 
ssh p-dachaproxy-22 "cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.`date +%Y%m%d`"
cd /tmp

echo "Please paste your personal git token"
echo "For instructions on how to create a token visit;"
echo "https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/"
read GIT_TOKEN

curl --header "Authorization: token $GIT_TOKEN" \
    --header "Accept: application/vnd.github.v3.raw" \
    --remote-name \
    --location $GIT_FILE

unset GIT_TOKEN

#Check for syntax validity of new haproxy.cfg 

if [ "`haproxy -f /tmp/haproxy.cfg -c 2>/dev/null`" == "Configuration file is valid" ]
  then
    scp /tmp/haproxy.cfg p-dachaproxy-22:/etc/haproxy/haproxy.cfg
    mv -f /tmp/haproxy.cfg /etc/haproxy/haproxy.cfg
    service haproxy reload
    ssh p-dachaproxy-22 "service haproxy reload"
  else
    echo 'Config file wrong - review github code'
    rm -f /tmp/haproxy.cfg
    exit
fi
