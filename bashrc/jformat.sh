#! /bin/bash
ECLIPSEFORMAT=.eclipseformatrc
folderForGit=$(realpath .)
~/loadrc/gitrc/checkGitStatus.sh
if [ $? -ne 0 ]
then
  exit 1
fi
LIST=( -name \*.java -o -name \*.vala )
find "$folderForGit" -type f \( "${LIST[@]}" \) -exec astyle --mode=java -nfxejoU -y  --max-code-length=150 -s2 --style=allman -pcH {} \;
~/loadrc/gitrc/gci.sh
