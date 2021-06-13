#!/bin/zsh
SCRIPT=$(realpath "$0") && \
    SCRIPTPATH=$(dirname "$SCRIPT") && \
    cd "$SCRIPTPATH" || cd ~/loadrc/

cp -fv ./Library/LaunchAgents/pbcopy.plist ~/Library/LaunchAgents/pbcopy.plist
cp -fv ./Library/LaunchAgents/pbpaste.plist ~/Library/LaunchAgents/pbpaste.plist

launchctl load ~/Library/LaunchAgents/pbcopy.plist
launchctl load ~/Library/LaunchAgents/pbpaste.plist
launchctl start ~/Library/LaunchAgents/pbcopy.plist
launchctl start ~/Library/LaunchAgents/pbpaste.plist
