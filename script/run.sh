#!/usr/bin/bash

# 检查依赖项是否存在
if ! command -v wget &> /dev/null; then
    echo "Error: wget is not installed. Please install wget." >&2
    exit 1
fi

if ! command -v unzip &> /dev/null; then
    echo "Error: unzip is not installed. Please install unzip." >&2
    exit 1
fi

if ! command -v python3 &> /dev/null; then
    echo "Error: python3 is not installed. Please install python3." >&2
    exit 1
fi

# 存放测试结果
if [ ! -d result_latest ]; then
    mkdir result_latest
fi
if [ ! -d bak_result ]; then
    mkdir bak_result
fi

# 获取 baipiaoIP
echo "开始获取 baipiaoIP"
wget -O baipiao.zip http://baipiao.test.upcdn.net || { echo "Error: Failed to download baipiao.zip." >&2; exit 1; }
unzip -o baipiao.zip -d baipiao || { echo "Error: Failed to unzip baipiao.zip." >&2; exit 1; }

# 格式化
python3 baipiao-ipTest-format.py -i baipiao -o baipiao || { echo "Error: Failed to format baipiao IP data." >&2; exit 1; }

count=$(wc -l < baipiao/ips_with_ports.txt)
echo "共获取到 $count 个IP"

export run_msg="baipiao 共获取到 $count 个IP"

chmod +x ./ipTest/ipTest
./ipTest/ipTest -file baipiao/ips_with_ports.txt -outfile baipiao.csv || { echo "Error: Failed to test baipiao IP addresses." >&2; exit 1; }
rm -rf baipiao

count=$(wc -l < baipiao.csv)
echo "有效IP数量为 $count 个"
export run_msg="$run_msg"$'\n'"baipiao 有效IP数量为 $count 个"$'\n'

# 备份 baipiao 文件
if [ ! -d bak_baipiao ]; then
    mkdir bak_baipiao
fi
mv baipiao.zip bak_baipiao/$(date +"%Y%m%d%H%M%S").zip
cp baipiao.csv result_latest/baipiao.csv
mv baipiao.csv bak_result/$(date +"%Y%m%d%H%M%S")_baipiao.csv

# 获取 proxyIP 与 rawIp
echo "开始获取 proxyIP 与 rawIp"
wget -O proxy.txt https://gh.xxooo.cf/https://github.com/ymyuuu/IPDB/blob/main/proxy.txt || { echo "Error: Failed to download proxy.txt." >&2; exit 1; }
wget -O raw_ip.txt https://gh.xxooo.cf/https://github.com/x-dr/iptest/blob/main/raw_ip.txt || { echo "Error: Failed to download raw_ip.txt." >&2; exit 1; }

# 合并 proxy.txt 和 raw_ip.txt
cat proxy.txt >> ip.txt
cat raw_ip.txt >> ip.txt
rm proxy.txt raw_ip.txt

count=$(wc -l < ip.txt)
echo "共获取到 $count 个IP"
export run_msg="$run_msg"$'\n'"ip-with-port共获取到 $count 个IP"$'\n'

# 添加端口号
python3 ip-add-port.py -i ip.txt -o ip-with-port.txt -p 443 || { echo "Error: Failed to add port to IP addresses." >&2; exit 1; }

# 测试 IP 地址
./ipTest/ipTest -file ip-with-port.txt -outfile ip-with-port.csv || { echo "Error: Failed to test IP addresses." >&2; exit 1; }
rm ip-with-port.txt

count=$(wc -l < ip-with-port.csv)
echo "ip-with-port有效IP数量为 $count 个"
run_msg="$run_msg"$'\n'"ip-with-port有效IP数量为 $count 个"$'\n'

echo -e "$run_msg" > npipe &

# 备份 IP 文件
if [ ! -d bak_ip ]; then
    mkdir bak_ip
fi
mv ip.txt bak_ip/$(date +"%Y%m%d%H%M%S").txt
cp ip-with-port.csv result_latest/ip-with-port.csv
mv ip-with-port.csv bak_result/$(date +"%Y%m%d%H%M%S")_ip.csv

echo "任务完成"
