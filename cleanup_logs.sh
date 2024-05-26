#!/bin/bash

# Download

wget -O /root/cleanup_logs.sh  https://raw.githubusercontent.com/NyiNyiSoePaing/shell_script/main/docker_cleanup_logs.sh

chmod +x /root/cleanup_logs.sh

cat <(crontab -l) <(echo "0 2 * * * /root/cleanup_logs.sh >> /root/cleanup_logs.log 2>&1") | crontab -

