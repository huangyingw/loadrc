#!/usr/bin/env python3
import subprocess
from handle_vtt import *
from os import path
import sys
import platform


fileVar = sys.argv[1]
lineVar = sys.argv[2]
targetFile = path.dirname(fileVar) + '/' + lineVar


def callvlc(targetFile, start=0):
    if targetFile:
        if platform.system() == 'Darwin':
            subprocess.check_call(['/Applications/VLC.app/Contents/MacOS/VLC', '-f', '--macosx-continue-playback=2', '--start-time=' + str(start), targetFile])
        else:
            subprocess.check_call(['smplayer', '-fullscreen', targetFile])


if path.exists(targetFile):
    callvlc(targetFile)
else:
    start = parse_vtt_str(lineVar)
    targetFile = find_vtt_video(fileVar)
    callvlc(targetFile, start)
