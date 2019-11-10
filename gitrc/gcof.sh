# this is used to reset back to the latest change on the file.
commit=`git rev-list --branches -n 1 HEAD -- "$1"`
if [ -z "$2" ]
then
    git show HEAD:"$1" > "$1".bak
else
    git show "$2":"$1" > "$1".bak
fi
