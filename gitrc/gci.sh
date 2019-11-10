~/loadrc/gitrc/include_gitconfig.sh
. ~/loadrc/gitrc/getCommit_message.sh "$1"
git commit -am "$commit_message"
~/loadrc/gitrc/postCommit.sh
