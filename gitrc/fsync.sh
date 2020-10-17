#!/bin/zsh
if [ -z "$1" ]
then
    TARGETEDIR="$pwd"
else
    TARGETEDIR="$1"
fi
RESULT="$TARGETEDIR"/fgs.findresult
function rec_dir() {
    if [[ $2 -gt 11 ]]
    then
        return
    fi
    for file in `ls -al $1`
    do
        if [ -d "$1/$file" ] && [ "$file" != ".." ] && [ "$file" != "." ]
        then
            if [ -d "$1/$file/.git" ]
            then
                cd "$1/$file"
                if [ -n "$(git status --porcelain)" ]
                then
                    echo "$1/$file" >> "$RESULT"
                else
                    ~/loadrc/gitrc/gsync.sh
                fi
                cd - 1>/dev/null
            else
                if [ "$file" != ".git" ] && [ "$file" != ".." ] && [ "$file" != "." ]
                then
                    rec_dir "$1/$file" $(($2 + 1))
                fi
            fi
        fi
    done
}
rm "$RESULT"
rec_dir "$TARGETEDIR" 0
