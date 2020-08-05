#!/usr/bin/env python3
from os import path
import sys
from pathlib import Path
home = str(Path.home()) + '/'
sys.path.insert(1, home + 'loadrc/pythonrc/')
from parse_vtt import parse_vtt_str

print("sys.argv[0] --> %s" % sys.argv[0])
print("sys.argv[1] --> %s" % sys.argv[1])
print("sys.argv[2] --> %s" % sys.argv[2])
fileVar = sys.argv[1]
lineVar = sys.argv[2]
print("fileVar --> %s" % fileVar)
print("lineVar --> %s" % lineVar)
targetFile = path.dirname(fileVar) + '/' + lineVar
print("targetFile --> %s" % targetFile)
if path.exists(targetFile):
    print("path.exists --> ")
    start = parse_vtt_str(lineVar)
    print("start --> %s" % start)
else:
    print("path.exists not --> ")
