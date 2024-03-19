#!/usr/bin/bash


github_token="your github token"
gist_id="your gist id"
file_path="result_latest/ip-with-port.csv"
file_path2="result_latest/baipiao.csv"

python3 update_gist.py -t "$github_token" -g "$gist_id" -f "$file_path"

python3 update_gist.py -t "$github_token" -g "$gist_id" -f "$file_path2"
