#!/usr/bin/bash


cd /home/ubuntu/cfProxyIpTest
echo $(date +"%Y%m%d%H%M%S") >> testfile.txt
bash run_all.sh >> logs/$(date +"%Y%m%d%H%M%S").log 2>&1
