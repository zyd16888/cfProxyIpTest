#!/usr/bin/bash

echo "开始运行脚本"
start_time=$(date +"%Y%m%d%H%M%S")

bash script/run.sh

bash script/update_gist.sh

echo "脚本运行完成"
end_time=$(date +"%Y%m%d%H%M%S")
echo "脚本运行时间: $[$end_time-$start_time]秒"
