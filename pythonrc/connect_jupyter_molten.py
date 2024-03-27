import requests
import json
import os

# Jupyter服务器的基础URL和认证信息
JUPYTER_BASE_URL = "http://localhost:8888"
JUPYTER_TOKEN = "your_jupyter_token_here"

# 启动内核并获取连接信息的API路径
KERNELS_API = f"{JUPYTER_BASE_URL}/api/kernels"
CONNECTION_FILE_PATH = "./jupyter_kernel_connection.json"

def start_kernel():
    headers = {'Authorization': f'token {JUPYTER_TOKEN}'}
    data = {'name': 'python3'}
    response = requests.post(KERNELS_API, headers=headers, json=data)
    if response.status_code == 201:
        return response.json()
    else:
        raise Exception("Failed to start kernel")

def get_kernel_connection_info(kernel_id):
    kernel_api = f"{KERNELS_API}/{kernel_id}/connection"
    headers = {'Authorization': f'token {JUPYTER_TOKEN}'}
    response = reques ts.get(kernel_api, headers=headers)
    if response.status_code == 200:
        return response.json()
    else:
        raise Exception("Failed to get kernel connection info")

def create_connection_file(connection_info):
    with open(CONNECTION_FILE_PATH, 'w') as f:
        json.dump(connection_info, f)
        print(f"Connection file created at {CONNECTION_FILE_PATH}")

def main():
    kernel = start_kernel()
    print(f"Kernel started with ID: {kernel['id']}")
    connection_info = get_kernel_connection_info(kernel['id'])
    create_connection_file(connection_info)
    print(f"Use ':MoltenInit {CONNECTION_FILE_PATH}' in Neovim to connect to the kernel.")

if __name__ == "__main__":
    main()
