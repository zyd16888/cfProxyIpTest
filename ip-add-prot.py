import argparse

def add_port_to_ips(input_file_path, output_file_path, port):
    """
    从输入文件中读取IP地址，并将每个IP地址与指定端口写入到输出文件中
    """
    with open(input_file_path, 'r') as file:
        ip_addresses = file.readlines()

    with open(output_file_path, 'a') as file:
        for ip in ip_addresses:
            ip = ip.strip()  # 去除可能存在的换行符
            file.write(ip + f' {port}\n')

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Add port number to IP addresses in a file.')
    parser.add_argument('-i', '--input_file_path', type=str, help='Input file containing IP addresses', required=True)
    parser.add_argument('-o', '--output_file_path', type=str, help='Output file to save IP addresses with port', required=True)
    parser.add_argument('-p', '--port', type=str, help='Port number to be added to IP addresses', required=True)
    args = parser.parse_args()

    add_port_to_ips(args.input_file_path, args.output_file_path, args.port)
