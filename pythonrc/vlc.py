#!/usr/bin/env python3
import re
import sys
import subprocess
import os
import pyautogui
import time


def time_to_seconds(time_string):
    time_parts = time_string.split(":")
    if len(time_parts) == 3:
        hours, minutes, seconds = map(int, time_parts)
        total_seconds = hours * 3600 + minutes * 60 + seconds
    elif len(time_parts) == 2:
        minutes, seconds = map(int, time_parts)
        total_seconds = minutes * 60 + seconds
    else:
        total_seconds = 0
    return total_seconds


def split_string(string):
    # Split string into path and time using regex
    pattern = r"^(.*?)(?::(\d{1,2}:\d{1,2}(?::\d{1,2})?))$"
    match = re.match(pattern, string)
    if match:
        # Calculate time in seconds from the matched time string
        time_seconds = time_to_seconds(match.group(2))
        return time_seconds
    else:
        return 0


def open_in_vlc(file_path, cur_line):
    os.chdir(os.path.dirname(file_path))
    time = split_string(cur_line)
    print("Opening in VLC: " + cur_line + " at " + str(time) + "")

    if time:
        subprocess.run(
            [
                "/Applications/VLC.app/Contents/MacOS/VLC",
                "--sub-language",
                "Chinese",
                "--sub-autodetect-file",
                "-f",
                "--macosx-continue-playback=2",
                "--rate=2.0",
                "--start-time=" + str(time),
                cur_line,
            ]
        )
    else:
        subprocess.run(
            [
                "/Applications/VLC.app/Contents/MacOS/VLC",
                "--sub-language",
                "Chinese",
                "--sub-autodetect-file",
                "-f",
                "--macosx-continue-playback=2",
                "--rate=2.0",
                cur_line,
            ]
        )

    # Exit iTerm2 full screen mode
    pyautogui.hotkey("command", "enter")


if __name__ == "__main__":
    # Use the command line arguments to get the file path and line
    file_path = sys.argv[1]
    cur_line = sys.argv[2]


    # Split the cur_line string by comma and take the second part, only if a comma is present
    if "," in cur_line:
        cur_line = cur_line.split(",", 1)[1]

    open_in_vlc(file_path, cur_line)
