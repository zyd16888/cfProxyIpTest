#!/bin/bash

# 检查参数数量
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <username> <token> <gist_id> <file_path>"
    exit 1
fi

# 从参数中读取值
username="$1"
token="$2"
gist_id="$3"
file_path="$4"

# 调用 Python 脚本
python3 update_gist.py -u "$username" -t "$token" -g "$gist_id"  -f "$file_path"
