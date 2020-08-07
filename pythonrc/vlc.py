#!/usr/bin/env python3
import subprocess
from handle_vtt import *
from os import path
import sys

fileVar = sys.argv[1]
lineVar = sys.argv[2]
targetFile = path.dirname(fileVar) + '/' + lineVar


def callvlc(targetFile, start=0):
    subprocess.check_call(['/Applications/VLC.app/Contents/MacOS/VLC', '-f', '--macosx-continue-playback=2', targetFile])


if path.exists(targetFile):
    print("path.exists --> ")
    callvlc(targetFile)
else:
    print("path.exists not --> ")
    start = parse_vtt_str(lineVar)
    targetFile = find_vtt_video(fileVar)
    print("targetFile --> %s" % targetFile)
    print("start --> %s" % start)
