#!/bin/zsh

# 检查是否有足够的参数传入
if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <PDF file>"
    exit 1
fi

# 获取输入的PDF文件名
input_pdf="$1"

# 从输入文件名中移除.pdf后缀，以便于添加-decrypt
output_pdf="${input_pdf%.pdf}-decrypt.pdf"

# 检查输出文件是否存在，如果存在，则不给出任何提示直接覆盖
if [[ -f "$output_pdf" ]]; then
    echo "Output file $output_pdf already exists. It will be overwritten."
fi

# 执行解密命令
qpdf --decrypt "$input_pdf" "$output_pdf"

# 检查命令是否成功执行
if [[ $? -eq 0 ]]; then
    echo "Decryption successful. Output file: $output_pdf"
else
    echo "Decryption failed."
    exit 1
fi
