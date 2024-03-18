import argparse
import requests

def update_gist(username, token, gist_id, file_path):
    # 读取本地文件内容
    with open(file_path, 'rb') as file:
        content = file.read()

    # 构建 API 请求的 URL
    url = f"https://api.github.com/gists/{gist_id}"

    # 构建 HTTP 请求的头部
    headers = {
        "Authorization": f"token {token}",
        "Accept": "application/vnd.github.v3+json"
    }

    # 构建 JSON 数据
    data = {
        "files": {
            "result.csv": {
                "content": content.decode('utf-8')
            }
        }
    }

    # 发送 HTTP 请求
    response = requests.patch(url, headers=headers, json=data)

    # 检查响应状态码
    if response.status_code == 200:
        print("文件已成功更新到 Gist。")
    else:
        print(f"更新 Gist 时出错：{response.status_code} - {response.text}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Update a GitHub Gist with a local file.")
    parser.add_argument("-u", "--username", help="GitHub username", required=True)
    parser.add_argument("-t", "--token", help="GitHub access token", required=True)
    parser.add_argument("-g", "--gist_id", help="Gist ID", required=True)
    parser.add_argument("-f", "--file_path", help="Local file path", required=True)

    args = parser.parse_args()

    update_gist(args.username, args.token, args.gist_id, args.file_path)
