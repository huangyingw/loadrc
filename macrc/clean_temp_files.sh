#!/bin/zsh

# Clean user caches
rm -rf ~/Library/Caches/*

# Clean system caches
sudo rm -rf /Library/Caches/*

# Clean temporary files
sudo rm -rf /private/var/folders/*/*/*/*

# Clear swap files
sudo rm -rf /private/var/vm/*

# Empty the Trash
sudo rm -rf ~/.Trash/*

echo "Temporary files and caches have been cleaned."
