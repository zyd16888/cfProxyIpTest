#!/usr/bin/bash

echo "开始运行脚本"
start_time=$(date +"%Y%m%d%H%M%S")

bash script/run.sh

export github_token="your github token"
export gist_id="your gist id"
export area=""  # 填写地区, 可选参数

update_msg=$(script/update_gist.sh)

echo "脚本运行完成"
end_time=$(date +"%Y%m%d%H%M%S")
echo "脚本运行时间: $[$end_time-$start_time]秒"

# sond message
echo -e "$update_msg"

# 设置环境变量
export QYWX_AM=""

send_msg="$run_msg\n$update_msg"$'\n\n'"脚本运行时间: $((end_time - start_time))秒"

python3 sendNotify.py -t "IP测速运行结果" -c "$send_msg"
