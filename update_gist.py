import argparse
import requests
import os
import time

MAX_RETRIES = 3
RETRY_DELAY = 2  # seconds

def update_gist(token, gist_id, file_path):

    file_name = os.path.basename(file_path)
    if args.area:
        file_name = file_name.replace(".", f"-{args.area}.")

    # 读取本地文件内容
    try:
        with open(file_path, 'rb') as file:
            content = file.read()
    except FileNotFoundError:
        print(f"Error: File '{file_path}' not found.")
        return
    except Exception as e:
        print(f"Error reading file '{file_path}': {e}")
        return

    # 构建 API 请求的 URL
    url = f"https://api.github.com/gists/{gist_id}"

    # 构建 HTTP 请求的头部
    headers = {
        "Authorization": f"token {token}",
        "Accept": "application/vnd.github.v3+json"
    }

    # 构建 JSON 数据
    data = {"files": {file_name: {"content": content.decode("utf-8")}}}

    retries = 0
    while retries < MAX_RETRIES:
        try:
            # 发送 HTTP 请求
            response = requests.patch(url, headers=headers, json=data)
            response.raise_for_status()  # Raise an HTTPError for bad responses
        except requests.exceptions.RequestException as e:
            print(f"Error occurred during request: {e}")
            retries += 1
            if retries < MAX_RETRIES:
                print(f"Retrying... (Attempt {retries})")
                time.sleep(RETRY_DELAY)
        else:
            # 检查响应状态码
            if response.status_code == 200:
                print(f"File '{file_name}' has been successfully updated to Gist.")
                return
            else:
                print(f"Error updating Gist: {response.status_code} - {response.text}")
                retries += 1
                if retries < MAX_RETRIES:
                    print(f"Retrying... (Attempt {retries})")
                    time.sleep(RETRY_DELAY)
                else:
                    print("Reached maximum retry attempts, unable to update Gist.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Update a GitHub Gist with a local file.")
    parser.add_argument("-t", "--token", help="GitHub access token", required=True)
    parser.add_argument("-g", "--gist_id", help="Gist ID", required=True)
    parser.add_argument("-f", "--file_path", help="Local file path", required=True)
    parser.add_argument("-a", "--area", help="run area name", required=False)

    args = parser.parse_args()

    update_gist(args.token, args.gist_id, args.file_path)
