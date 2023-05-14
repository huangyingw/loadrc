#!/bin/bash

# Send the command + enter hotkey using osascript
osascript -e 'tell application "System Events" to keystroke return using command down'

# Add a short delay to ensure the keystroke is sent
sleep 1

# Call the Python script
python3 ~/loadrc/pythonrc/vlc.py "$1" "$2"
