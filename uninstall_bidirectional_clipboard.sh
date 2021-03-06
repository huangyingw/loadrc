#!/bin/zsh
SCRIPT=$(realpath "$0") && \
    SCRIPTPATH=$(dirname "$SCRIPT") && \
    cd "$SCRIPTPATH" || cd ~/loadrc/

launchctl stop ~/Library/LaunchAgents/pbcopy.plist
launchctl stop ~/Library/LaunchAgents/pbpaste.plist

launchctl unload ~/Library/LaunchAgents/pbcopy.plist
launchctl unload ~/Library/LaunchAgents/pbpaste.plist

rm ~/Library/LaunchAgents/pbcopy.plist
rm ~/Library/LaunchAgents/pbpaste.plist
