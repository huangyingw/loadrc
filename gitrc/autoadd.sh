#!/bin/zsh
fileName="$1"

if [[ "$fileName" != *"../"* ]]
then
    filesProj=$(~/loadrc/bashrc/find_up.sh $(pwd) "files.proj")
    fileName=$(echo $fileName | sed 's/ /\\ /g')

    if ( grep -Fxq "\"./$fileName\"" "$filesProj" ) && ( ! git ls-files --error-unmatch "$fileName" )
    then
        git add -f "$fileName"
    fi
fi
