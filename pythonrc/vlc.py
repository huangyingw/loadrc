#!/usr/bin/env python3
import json
import os
import pyautogui
import re
import subprocess
import sys
import time


def time_to_seconds(time_string):
    print("Converting time string to seconds: %s" % time_string)
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
    print("Splitting string: %s" % string)
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
    print("Opening file in VLC: %s" % file_path)

    # Convert the input string to a valid JSON string
    cur_line = json.dumps(cur_line)

    # Remove outer quotes from the current line and unescape unicode characters
    cur_line = json.loads(cur_line).strip().strip('"')

    # If the path starts with "./", remove it
    if cur_line.startswith("./"):
        cur_line = cur_line[2:]

    # Get the directory containing the text file
    dir_path = os.path.dirname(file_path)

    # Append cur_line to the directory path
    file_full_path = os.path.join(dir_path, cur_line)

    # Check if the file exists
    if not os.path.isfile(file_full_path):
        print(f'The file "{file_full_path}" does not exist.')
        print(f"Current directory: {os.getcwd()}")
        return

    time = split_string(file_full_path)
    print("Opening in VLC: " + file_full_path + " at " + str(time))

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
                file_full_path,
            ],
            stdout=subprocess.DEVNULL,  # Redirect stdout to DEVNULL
            stderr=subprocess.DEVNULL,  # Redirect stderr to DEVNULL
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
                file_full_path,
            ],
            stdout=subprocess.DEVNULL,  # Redirect stdout to DEVNULL
            stderr=subprocess.DEVNULL,  # Redirect stderr to DEVNULL
        )


if __name__ == "__main__":
    print("Script started with arguments: %s" % sys.argv)
    # Use the command line arguments to get the file path and line
    file_path = sys.argv[1]
    cur_line = sys.argv[2]

    # Split the cur_line string by comma and take the second part, only if a comma is present
    if "," in cur_line:
        cur_line = cur_line.split(",", 1)[1]

    open_in_vlc(file_path, cur_line)
