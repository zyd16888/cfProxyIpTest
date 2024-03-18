#!/bin/bash

if [ ! -d logs ]; then
    mkdir logs
fi

echo "开始运行脚本"
start_time=$(date +"%Y%m%d%H%M%S")

bash run.sh

github_token="your github token"
gist_id="your gist id"
file_path="result_latest/ip-with-port.csv"
file_path2="result_latest/baipiao.csv"

python3 update_gist.py -t "$github_token" -g "$gist_id" -f "$file_path"

python3 update_gist.py -t "$github_token" -g "$gist_id" -f "$file_path2"

echo "脚本运行完成"
end_time=$(date +"%Y%m%d%H%M%S")
echo "脚本运行时间: $[$end_time-$start_time]秒"
