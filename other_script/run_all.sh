#!/usr/bin/bash

cd /home/ubuntu/cfProxyIpTest/other_script

start_time=$(date +"%Y%m%d%H%M%S")

if [ ! -d logs ]; then
    mkdir logs
fi

bash run_iptest.sh >> logs/$(date +"%Y%m%d%H%M%S").log 2>&1

bash run_format.sh ./result/

end_time=$(date +"%Y%m%d%H%M%S")

echo "脚本运行时间: $[$end_time-$start_time]秒"

# 设置环境变量
export QYWX_AM=""

# 判断环境变量是否为空
if [ -n "$QYWX_AM" ]; then
    # ./upx sync --strong ./result/
    update_msg=$(./upx --auth sync --strong ./format_result / )
    send_msg="$update_msg"$'\n\n'"脚本运行时间: $((end_time - start_time))秒"
    python3 ../sendNotify.py -t "IP测速运行结果" -c "$send_msg"
fi


