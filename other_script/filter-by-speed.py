import csv
import os

def filter_speed(input_files, output_file, threshold_speed):
    with open(output_file, 'w', newline='', encoding='utf-8') as f_output:
        writer = csv.writer(f_output)

        # 写入标题行
        writer.writerow(['IP地址', '端口', '回源端口', 'TLS', '数据中心', '地区', '城市', '国家', 'IP类型', 'TCP延迟(ms)', '速度(kb/s)'])

        # 遍历所有输入文件
        for input_file in input_files:
            with open(input_file, 'r', newline='', encoding='utf-8') as f_input:
                reader = csv.reader(f_input)
                next(reader)  # 跳过标题行

                # 遍历数据行
                for row in reader:
                    # 检查速度是否大于指定阈值
                    speed = float(row[-1])  # 最后一列是速度
                    if speed > threshold_speed:
                        writer.writerow(row)

# 输入目录
input_directory = './format_result/'

# 输出文件
output_file = 'format_result/output_filtered.csv'

# 指定速度阈值
threshold_speed = 5000  # 根据需要更改阈值

# 获取所有符合条件的文件
input_files = [os.path.join(input_directory, filename) for filename in os.listdir(input_directory) if filename.endswith(".csv")]

# 进行过滤并写入新文件
filter_speed(input_files, output_file, threshold_speed)
