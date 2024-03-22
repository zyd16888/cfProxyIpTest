#!/bin/bash

# 定义要查询的IATA列表
iata_list=("SIN" "HKG" "LAX" "NRT" "SJC" "KIX" "ICN" "CDG" "FRA" "AMS"
           "TPE" "SYD" "BOM" "ARN" "LHR" "OSL" "IAD" "YYZ" "MXP" "YUL"
           "ORD" "CPH" "GRU" "MFM" "CPT" "SEA" "ATL" "IAH" "CGK" "DFW"
           "FCO" "MAD" "MRS" "PDX" "DUB" "MEL" "DEL" "DME" "BUF" "EWR"
           "KHH" "BUD" "ZRH" "MUC" "WAW" "VIE" "KUL" "BKK" "LOS" "MNL"
           "PHX" "MIA" "BNA" "MAN" "JIB" "DUR" "DEN" "PHL" "MSP" "DTW"
           "BOS" "LAS" "MCI" "SFO" "DXB" "JNB" "SMF" "TLH" "SCL" "PER"
           "VNO" "QRO" "HEL")

# 遍历IATA列表
for iata_code in "${iata_list[@]}"
do
    # 调用相应的命令，将iata code传递给该命令
    ./iptest_linux_amd64 -gui=false -iata="$iata_code"
done