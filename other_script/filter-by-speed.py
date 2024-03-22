import argparse
import csv
import os

def filter_speed(input_directory, output_file, threshold_speed):
    if os.path.exists(output_file):
        write_header = False
    else:
        write_header = True

    with open(output_file, 'a', newline='') as f_output:
        writer = csv.writer(f_output)

        if write_header:
            writer.writerow(['IP地址', '端口', '回源端口', 'TLS', '数据中心', '地区', '城市', '国家', 'IP类型', 'TCP延迟(ms)', '速度(kb/s)'])

        # 遍历所有输入文件
        for filename in os.listdir(input_directory):
            if filename.endswith(".csv"):
                input_file = os.path.join(input_directory, filename)
                with open(input_file, 'r', newline='') as f_input:
                    reader = csv.reader(f_input)
                    next(reader)  # 跳过标题行

                    # 遍历数据行
                    for row in reader:
                        # 检查速度是否大于指定阈值
                        speed = float(row[-1])  # 最后一列是速度
                        if speed > threshold_speed:
                            writer.writerow(row)

def main():
    parser = argparse.ArgumentParser(description="Filter CSV files by speed.")
    parser.add_argument("-i", "--input_directory", help="Input directory containing CSV files.")
    parser.add_argument("-o", "--output_file", help="Output file to save filtered results.")
    parser.add_argument("-s", "--threshold_speed", type=float, help="Threshold speed for filtering.")

    args = parser.parse_args()

    filter_speed(args.input_directory, args.output_file, args.threshold_speed)

if __name__ == "__main__":
    main()
