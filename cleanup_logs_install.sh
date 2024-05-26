#!/bin/bash

# Download
echo "script download"

rm /home/ubuntu/cleanup_logs.sh
wget -O /home/ubuntu/cleanup_logs.sh  https://raw.githubusercontent.com/NyiNyiSoePaing/shell_script/main/docker_cleanup_logs.sh

chmod +x /home/ubuntu/cleanup_logs.sh

echo "run script"
bash /home/ubuntu/cleanup_logs.sh

echo "setup cron"
cat <(sudo crontab -l) <(echo "0 2 * * * /home/ubuntu/cleanup_logs.sh >> /home/ubuntu/cleanup_logs.log 2>&1") | sudo crontab -

