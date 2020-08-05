#!/usr/bin/env python3
from os import path
import sys
from pathlib import Path
home = str(Path.home()) + '/'
sys.path.insert(1, home + 'loadrc/pythonrc/')
from parse_vtt import parse_vtt_str

with open(home + "loadrc/output.txt", "w") as text_file:
    text_file.write("sys.argv[0] --> %s\n" % sys.argv[0])
    text_file.write("sys.argv[1] --> %s\n" % sys.argv[1])
    text_file.write("sys.argv[2] --> %s\n" % sys.argv[2])
    fileVar = sys.argv[1]
    lineVar = sys.argv[2]
    text_file.write("fileVar --> %s\n" % fileVar)
    text_file.write("lineVar --> %s\n" % lineVar)
    targetFile = fileVar + '/' + lineVar
    text_file.write("targetFile --> %s\n" % targetFile)
    if path.exists(targetFile):
        text_file.write("path.exists --> \n")
        start = parse_vtt_str(lineVar)
        text_file.write("start --> %s\n" % start)
    else:
        text_file.write("path.exists not --> \n")
