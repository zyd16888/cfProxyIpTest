#!/usr/bin/bash
wget -O baipiao.zip https://zip.baipiao.eu.org

unzip baipiao.zip -d baipiao
# 格式化
python3 baipiao-ipTest-format.py -i baipiao -o baipiao

chmod +x ./ipTest/ipTest
./ipTest/ipTest -file baipiao/ips_with_ports.txt -outfile baipiaoip.csv


wget https://gh.xxooo.cf/https://github.com/ymyuuu/IPDB/blob/main/proxy.txt

cat proxy.txt >> ip.txt

wget https://gh.xxooo.cf/https://github.com/x-dr/iptest/blob/main/raw_ip.txt

cat raw_ip.txt >> ip.txt

python3 ip-add-port.py -i ip.txt -o ip-with-port.txt -p 443

./ipTest/ipTest -file ip-with-port.txt -outfile ip-with-port.csv





