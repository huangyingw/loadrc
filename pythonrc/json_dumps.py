#!/usr/bin/env python3
import json
import sys

print(json.dumps(sys.stdin.read().strip()))
