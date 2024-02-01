import sys
import socket


def send_file_paths(file_path):
    host = "localhost"  # 服务器地址
    port = 12345  # 服务器端口号

    with open(file_path, "r") as file:
        file_paths = file.read()

    # 创建 socket 并连接到服务器
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect((host, port))
        s.sendall(file_paths.encode())


if __name__ == "__main__":
    if len(sys.argv) > 1:
        send_file_paths(sys.argv[1])
    else:
        print("Usage: python send_paths.py <file_with_paths>")
