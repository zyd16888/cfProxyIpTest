import json
import csv
import argparse

# 读取 CSV 文件
def read_csv(csv_file):
    with open(csv_file, 'r', newline='', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        data = [row for row in reader]
    return data

# 修改数据并添加国家列
def modify_csv(data, location_dict):
    for row in data:
        iata = row['数据中心']
        if iata in location_dict:
            row['国家'] = location_dict[iata]['cca2']
            row['速度(kb/s)'] = float(row['速度(MB/s)']) * 1024
            row['IP类型'] = ""
            row.pop('速度(MB/s)')

    # 保存城市列的索引
    city_keys = list(data[0].keys())
    city_index = city_keys.index('城市')
    
    # 将国家列插入到城市列索引后面
    new_data = []
    for row in data:
        row_keys = list(row.keys())
        row_keys.insert(city_index + 1, '国家')
        row = {key: row[key] for key in row_keys}
        new_data.append(row)

    city_keys = list(data[0].keys())
    country_index = city_keys.index('国家')
    data=[]
    for row in new_data:
        row_keys = list(row.keys())
        row_keys.insert(country_index + 1, 'IP类型')
        row = {key: row[key] for key in row_keys}
        data.append(row)

    return data

# 保存修改后的 CSV 文件
def save_csv(data, output_file):
    fieldnames = data[0].keys()
    with open(output_file, 'w', newline='', encoding="utf-8") as file:
        writer = csv.DictWriter(file, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(data)

# 读取城市信息
location_dict = {}
def read_json(json_file):
    with open(json_file, 'r') as f:
        data = json.load(f)
        for airport in data:
            location_dict[airport['iata']] = airport
    return None



if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Format IP test result CSV file")
    parser.add_argument("-i","--input_file", type=str, help="Input CSV file")
    parser.add_argument("-o", "--output_file", type=str, help="Output CSV file")
    args = parser.parse_args()
    # 读取城市信息
    read_json("locations.json")

    # 读取 CSV 文件
    data = read_csv(args.input_file)

    # 修改 CSV 文件并添加国家列
    data = modify_csv(data, location_dict)

    # 保存修改后的 CSV 文件
    save_csv(data, args.output_file)

