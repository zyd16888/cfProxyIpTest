#!/usr/bin/bash

cd /home/ubuntu/cfProxyIpTest/other_script

if [ ! -d logs ]; then
    mkdir logs
fi

bash run_iptest.sh >> logs/$(date +"%Y%m%d%H%M%S").log 2>&1

bash run_format.sh ./result


