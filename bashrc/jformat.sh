#! /bin/bash
folderForGit=$(realpath .)
LIST=( -name \*.java -o -name \*.vala )
find "$folderForGit" -type f \( "${LIST[@]}" \) -exec astyle --mode=java -nfxejoU -y  --max-code-length=150 -s2 --style=allman -pcH {} \;
