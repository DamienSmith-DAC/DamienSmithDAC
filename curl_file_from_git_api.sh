echo "Please paste your personal git token"
echo "For instructions on how to create a token visit;"
echo "https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/"
read GIT_TOKEN
GIT_OWNER="DFSI-DAC"
GIT_REPO="Platform"
GIT_PATH="haproxy.cfg"
GIT_FILE="https://api.github.com/repos/$GIT_OWNER/$GIT_REPO/contents/$GIT_PATH"

curl --header "Authorization: token $GIT_TOKEN" \
    --header "Accept: application/vnd.github.v3.raw" \
    --remote-name \
    --location $GIT_FILE
