import os
import argparse

def get_files_in_directory(directory):
    """
    获取指定目录下所有文件的绝对路径列表
    """
    files = [os.path.join(directory, f) for f in os.listdir(directory) if os.path.isfile(os.path.join(directory, f))]
    return files

def extract_ips(file_path):
    """
    从文件中提取IP并添加端口号
    """
    ips_with_ports = []
    with open(file_path, 'r') as file:
        port = os.path.splitext(os.path.basename(file_path))[0].split('-')[-1] # 从文件名中提取端口号
        for line in file:
            ip = line.strip()
            ips_with_ports.append(ip + ' ' + port)
    return ips_with_ports

def main(input_directory, output_directory):
    """
    主函数，遍历目录下的文件，提取IP并写入新文件
    """
    if not os.path.exists(output_directory):
        os.makedirs(output_directory)
        print(f"目录 {output_directory} 已创建。")

    output_file_path = os.path.join(output_directory, 'ips_with_ports.txt')

    with open(output_file_path, 'w', encoding='utf-8') as output_file:
        files = get_files_in_directory(input_directory)
        for file_path in files:
            if file_path.endswith('.txt') and any(char.isdigit() or char == '-' for char in os.path.basename(file_path)):
                ips_with_ports = extract_ips(file_path)
                output_file.write('\n'.join(ips_with_ports) + '\n')
        print(f"文件 {output_file_path} 已生成。")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Extract IPs from files in a directory and add port numbers.')
    parser.add_argument('-i', '--input_directory', type=str, help='Input directory containing files', required=True)
    parser.add_argument('-o', '--output_directory', type=str, help='Output directory for the result file', required=True)
    args = parser.parse_args()

    main(args.input_directory, args.output_directory)
