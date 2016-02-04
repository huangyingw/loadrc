#! /bin/bash
ECLIPSEFORMAT=.eclipseformatrc
folderForGit=$(realpath .)
if  ( git status |grep -q 'nothing to commit' )
then
  LIST=( -name \*.java -o -name \*.vala )
  find "$folderForGit" -type f \( "${LIST[@]}" \) -exec astyle --mode=java -nfxejoOU -y  --max-code-length=150 -s2 --style=allman -pcH {} \;
  if [ -f "$ECLIPSEFORMAT" ]
  then
    find "$folderForGit" -type f \( "${LIST[@]}" \) -exec ~/bin/eclipse/eclipse -nosplash -application org.eclipse.jdt.core.JavaCodeFormatter -quiet -config ~/loadrc/vimrc/.vim/ftplugin/org.eclipse.jdt.core.prefs {} \;
  fi
else
  echo -e "${red}the git repository is unclean, please check it before continuing... ${NC}"
  exit 1
fi
~/loadrc/gitrc/gci.sh
