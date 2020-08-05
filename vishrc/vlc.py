#!/usr/bin/env python3
import sys
from pathlib import Path
home = str(Path.home()) + '/'

'''
with open("/Users/huangyingw/Dropbox/loadrc.home/output.txt", "w") as text_file:
    text_file.write("sys.argv[0] --> %s\n" % sys.argv[0])
    text_file.write("sys.argv[1] --> %s\n" % sys.argv[1])
    text_file.write("sys.argv[2] --> %s\n" % sys.argv[2])

print sys.argv[0] # prints python_script.py
print sys.argv[1] # prints var1
print sys.argv[2] # prints var2
'''
# insert at 1, 0 is the script path (or '' in REPL)
sys.path.insert(1, home + 'pythonrc/')


with open(home + "loadrc/output.txt", "w") as text_file:
    text_file.write("sys.argv[0] --> %s\n" % sys.argv[0])
    text_file.write("sys.argv[1] --> %s\n" % sys.argv[1])
    text_file.write("sys.argv[2] --> %s\n" % sys.argv[2])
    fileVar = sys.argv[1]
    lineVar = sys.argv[2]
    text_file.write("fileVar --> %s\n" % fileVar)
    text_file.write("lineVar --> %s\n" % lineVar)
