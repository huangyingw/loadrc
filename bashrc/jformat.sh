#! /bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
if [ -n "$1" ];
then
  folderForGit="$1"
else
  folderForGit=.
fi
if  ( git status "$folderForGit"|grep -q 'nothing to commit' )
then
  LIST=( -name \*.java -o -name \*.vala )
  find "$folderForGit" -type f \( "${LIST[@]}" \) -exec astyle --mode=java -nfxejoOU -y  --max-code-length=150 -s2 --style=allman -pcH {} \; -exec ~/bin/eclipse/eclipse -nosplash -application org.eclipse.jdt.core.JavaCodeFormatter -quiet -config ~/loadrc/vimrc/.vim/ftplugin/org.eclipse.jdt.core.prefs {} \;
else
  echo -e "${red}the git repository is unclean, please check it before continuing... ${NC}"
  exit 1
fi
~/loadrc/gitrc/gci.sh
