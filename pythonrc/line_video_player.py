#!/usr/bin/env python3
import sys
import subprocess
import json


def main():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <filename>")
        return 1

    filename = sys.argv[1]  # sys.argv[1] is already a Python string
    with open(filename, "r") as f:
        for line in f:
            line = line.strip()  # strip() removes leading/trailing white space
            if line:  # skip empty lines
                print(f"Playing: {line}")  # echo the current playing line

                # Convert filename and line to valid JSON strings
                filename_json = json.dumps(filename)
                line_json = json.dumps(line.strip(), ensure_ascii=False)

                # Call vlc.py script for each line
                command = f"python3 ~/loadrc/pythonrc/vlc.py {filename_json} {line_json}"
                print("Executing command:", command)
                subprocess.run(command, shell=True)

    return 0


if __name__ == "__main__":
    sys.exit(main())
