#!/usr/bin/bash

file_path="result_latest/ip-with-port.csv"
file_path2="result_latest/baipiao.csv"

sleep 5

output2=$(python3 update_gist.py -t "$github_token" -g "$gist_id" -f "$file_path2" -a "$area")

sleep 5

output1=$(python3 update_gist.py -t "$github_token" -g "$gist_id" -f "$file_path" -a "$area")

update_msg="$area 文件上传情况："

# 输出结果
# echo "output1 is $output1"
# echo "output2 is $output2"

update_msg="$update_msg\n文件 ip-with-port 更新日志：\n$output1"
update_msg="$update_msg\n文件 baipiao 更新日志：\n$output2"

echo -e "$update_msg"

