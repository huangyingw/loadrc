#!/usr/bin/env python3
from os import path
import sys
from pathlib import Path
home = str(Path.home()) + '/'
sys.path.insert(1, home + 'loadrc/pythonrc/')
from parse_vtt import parse_vtt_str

print("sys.argv[0] --> %s\n" % sys.argv[0])
print("sys.argv[1] --> %s\n" % sys.argv[1])
print("sys.argv[2] --> %s\n" % sys.argv[2])
fileVar = sys.argv[1]
lineVar = sys.argv[2]
print("fileVar --> %s\n" % fileVar)
print("lineVar --> %s\n" % lineVar)
targetFile = fileVar + '/' + lineVar
print("targetFile --> %s\n" % targetFile)
if path.exists(targetFile):
    print("path.exists --> \n")
    start = parse_vtt_str(lineVar)
    print("start --> %s\n" % start)
else:
    print("path.exists not --> \n")
