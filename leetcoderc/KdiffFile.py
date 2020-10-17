#!/usr/bin/env python3
import re
import os
import sys

fileName = sys.argv[1]
lines = [line.rstrip('\n') for line in open(fileName) ]

accepts = {}
for line in lines:
    num = re.findall(r'\/(\d+)', line)[0]
    accepts.setdefault(num, []).append(line)

for k in sorted(accepts, key=lambda k: len(accepts[k]), reverse=True):
    for i, val in enumerate(accepts[k]):
        for j in range(i + 1, len(accepts[k])):
            os.system('kdiff3' + ' ' + accepts[k][i] + ' ' + accepts[k][j])
