#!/usr/bin/env python3
from handle_vtt import *
from os import path
import platform
import subprocess
import sys
fileVar = sys.argv[1]
lineVar = sys.argv[2]
targetFile = path.dirname(fileVar) + '/' + lineVar


def callvlc(targetFile, start=0):
    if targetFile:
        if platform.system() == 'Darwin':
            if start == 0:
                subprocess.check_call(['/Applications/VLC.app/Contents/MacOS/VLC', '--sub-language', 'Chinese', '--sub-autodetect-file', '-f', '--macosx-continue-playback=2', '--rate=2.0', targetFile])
            else:
                subprocess.check_call(['/Applications/VLC.app/Contents/MacOS/VLC', '--sub-language', 'Chinese', '--sub-autodetect-file', '-f', '--macosx-continue-playback=2', '--start-time=' + str(start), targetFile])
        else:
            subprocess.check_call(['smplayer', '-fullscreen', targetFile])


if path.exists(targetFile):
    callvlc(targetFile)
else:
    start = parse_vtt_str(lineVar)
    targetFile = find_vtt_video(fileVar)
    callvlc(targetFile, start)
