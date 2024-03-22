#!/bin/bash

# 检查是否提供了目录路径作为参数
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# 获取传入的目录路径
directory="$1"


# 遍历目录下的所有以 .csv 结尾的文件
for file in "$directory"/*.csv; do
    # 检查文件是否存在
    if [ -f "$file" ]; then
        # 调用 Python 程序处理当前文件，并将输出放在当前目录下
        python3 format-ipTest-result.py -i "$file" -o "${file%.csv}_formatted.csv"
    fi
done


if [ ! -d format_result ]; then
    mkdir format_result
fi

timestamp=$(date +"%Y%m%d%H%M%S")

if [ ! -d format_result/bak_"$timestamp" ]; then
    mkdir -p format_result/bak_"$timestamp"
fi

mv format_result/*.csv format_result/bak_"$timestamp"/

mv "$directory"/*_formatted.csv format_result/

python3 ./filter-by-speed.py -i format_result -o filter-speed.csv -s 6000

mv filter-speed.csv ./format_result/