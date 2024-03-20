#!/usr/bin/bash

file_path="result_latest/ip-with-port.csv"
file_path2="result_latest/baipiao.csv"



output1=$(python3 update_gist.py -t "$github_token" -g "$gist_id" -f "$file_path" -a "$area")

output2=$(python3 update_gist.py -t "$github_token" -g "$gist_id" -f "$file_path2" -a "$area")

update_msg="$area 文件上传情况："

# 输出结果
# echo "output1 is $output1"
# echo "output2 is $output2"

# 进行条件判断
if [ "$output1" == "文件已成功更新到 Gist。" ]; then
    # 处理成功的情况
    # echo "文件 ip-with-port 成功更新到 Gist。"
    update_msg="$update_msg\n文件 ip-with-port 成功更新到 Gist。"
else
    # 处理失败的情况
    # echo "更新 Gist 失败。"
    update_msg="$update_msg\n文件 ip-with-port 更新到 Gist 失败."
fi

if [ "$output2" == "文件已成功更新到 Gist。" ]; then
    # 处理成功的情况
    # echo "文件 baipiao 成功更新到 Gist。"
    update_msg="$update_msg\n文件 baipiao 成功更新到 Gist。"
else
    # 处理失败的情况
    # echo "更新 Gist 失败。"
    update_msg="$update_msg\n文件 baipiao 更新到 Gist 失败."
fi

echo -e "$update_msg"