import sys
import time
import osascript
import subprocess
import vlc


def toggle_fullscreen():
    code, result, err = osascript.run(
        'tell application "System Events" to keystroke return using command down'
    )
    if code != 0:
        print(f"Error: {err}")
    else:
        print("Toggled full-screen mode")


def play_video(file_path, cur_line):
    vlc.open_in_vlc(file_path, cur_line)


if __name__ == "__main__":
    # Use the command line arguments to get the file path and line
    file_path = sys.argv[1]
    cur_line = sys.argv[2]

    # Toggle full-screen mode in iTerm2
    toggle_fullscreen()
    time.sleep(1)

    # Play the video
    play_video(file_path, cur_line)
