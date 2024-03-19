#!/usr/bin/bash

cd /home/ubuntu/cfProxyIpTest

if [ ! -d logs ]; then
    mkdir logs
fi

bash script/run_all.sh >> logs/$(date +"%Y%m%d%H%M%S").log 2>&1
