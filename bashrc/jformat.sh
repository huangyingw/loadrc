#! /bin/zsh
folderForGit=$(realpath .)
LIST=( -name \*.java -o -name \*.vala )

if [ -f $HOME/.workrc ]
then
    find "$folderForGit" -type f \( "${LIST[@]}" \) -exec astyle --mode=java -nfxejoU -y -s2 --style=java -pcH {} \;
else
    find "$folderForGit" -type f \( "${LIST[@]}" \) -exec astyle --mode=java -nfxejoUys4pHU --style=allman -pcH {} \;
fi
