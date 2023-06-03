import json
import sys

print(json.dumps(sys.stdin.read().strip()))
