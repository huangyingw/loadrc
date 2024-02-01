import subprocess
import sys
import os
import time
import socket

# 程序的完整路径和日志文件
PROGRAM_PATH = os.path.expanduser("~/loadrc/plantumlmacviewer/main.py")
LOG_FILE = os.path.expanduser("~/plantumlmacviewer.log")

# 套接字服务器的地址和端口
SOCKET_HOST = "localhost"
SOCKET_PORT = 12345


def check_and_start_program():
    """检查服务器程序是否运行，如果没有，则启动它。"""
    command = f"nohup python {PROGRAM_PATH} > {LOG_FILE} 2>&1 &"
    try:
        # 尝试找到正在运行的程序进程
        subprocess.check_output(
            ["pgrep", "-f", PROGRAM_PATH], stderr=subprocess.STDOUT
        )
        print("服务器程序已在运行。")
    except subprocess.CalledProcessError:
        # 如果没有找到进程，启动服务器程序
        print("服务器程序未运行，正在启动...")
        subprocess.Popen(
            command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )
        print(f"日志文件: {LOG_FILE}")
        time.sleep(1)  # 等待一秒以确保程序已启动


def send_file_paths(file_path):
    """读取文件路径并通过套接字发送到服务器。"""
    with open(file_path, "r") as file:
        file_paths = file.read()

    # 创建 socket 并连接到服务器
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect((SOCKET_HOST, SOCKET_PORT))
        s.sendall(file_paths.encode())


if __name__ == "__main__":
    # 首先检查并尝试启动服务器程序
    check_and_start_program()

    # 然后发送文件路径
    if len(sys.argv) > 1:
        send_file_paths(sys.argv[1])
    else:
        print("Usage: python send_paths.py <file_with_paths>")
