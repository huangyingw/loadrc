#! /bin/bash
ECLIPSEFORMAT=.eclipseformatrc
folderForGit=$(realpath .)
~/loadrc/gitrc/checkGitStatus.sh
if [ $? -ne 0 ]
then
  exit 1
fi
LIST=( -name \*.java -o -name \*.vala )
find "$folderForGit" -type f \( "${LIST[@]}" \) -exec astyle --mode=java -nfxejoOU -y  --max-code-length=150 -s2 --style=allman -pcH {} \;
if [ -f "$ECLIPSEFORMAT" ]
then
  find "$folderForGit" -type f \( "${LIST[@]}" \) -exec ~/bin/eclipse/eclipse -nosplash -application org.eclipse.jdt.core.JavaCodeFormatter -quiet -config ~/loadrc/vimrc/.vim/ftplugin/org.eclipse.jdt.core.prefs {} \;
fi
~/loadrc/gitrc/gci.sh
