#!/usr/bin/env python3
import subprocess
from handle_vtt import *
from os import path
import sys

fileVar = sys.argv[1]
lineVar = sys.argv[2]
targetFile = path.dirname(fileVar) + '/' + lineVar


def callvlc(targetFile, start=0):
    if targetFile:
        subprocess.check_call(['/Applications/VLC.app/Contents/MacOS/VLC', '-f', '--macosx-continue-playback=2', '--start-time=' + str(start), targetFile])


if path.exists(targetFile):
    callvlc(targetFile)
else:
    start = parse_vtt_str(lineVar)
    targetFile = find_vtt_video(fileVar)
    callvlc(targetFile, start)
