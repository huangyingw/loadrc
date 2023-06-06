#!/usr/bin/env python3
import json
import sys

input_string = sys.stdin.read().strip()
# Do not escape unicode characters and avoid double quoting
json_string = json.dumps(input_string, ensure_ascii=False)
# Print without surrounding quotes
print(json_string[1:-1])
