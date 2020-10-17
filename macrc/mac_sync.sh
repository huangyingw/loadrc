#!/bin/zsh
rsync -aHv --progress --delete-before --force  ~/Library/Application\ Support/Google/Chrome/Default/ mbp:"~/Library/Application\ Support/Google/Chrome/Default/"
