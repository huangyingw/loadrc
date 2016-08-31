#! /bin/bash
folderForGit=$(realpath .)
LIST=( -name \*.java -o -name \*.vala )
if [ -f $HOME/.workrc ]
then
  find "$folderForGit" -type f \( "${LIST[@]}" \) -exec astyle --mode=java -nfxejoU -y  --max-code-length=150 -s2 --style=java -pcH {} \;
else
  find "$folderForGit" -type f \( "${LIST[@]}" \) -exec astyle --mode=java -nfxejoU -y  --max-code-length=150 -s2 --style=allman -pcH {} \;
fi
