#!/bin/bash

# Call the modified Python script
python3 ~/loadrc/pythonrc/vlc.py "$1" "$2"

## Add a delay (e.g., 10 seconds) before sending the keystroke
#sleep 10
#
## Send the command + enter hotkey using osascript
#osascript -e 'tell application "System Events" to keystroke return using command down'
