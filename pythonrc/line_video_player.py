import sys
import subprocess
from shlex import quote


def main():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <filename>")
        return 1

    filename = sys.argv[1]
    with open(filename, "r") as f:
        for line in f:
            line = line.strip()
            if line:  # skip empty lines
                print(f"Playing: {line}")  # echo the current playing line
                # Call vlc.py script for each line
                subprocess.run(
                    f'~/loadrc/pythonrc/vlc.py "{quote(filename)}" "{quote(line)}"',
                    shell=True,
                )
    return 0


if __name__ == "__main__":
    sys.exit(main())
