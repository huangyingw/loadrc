#!/bin/zsh
file="$1"

if [ $(basename "$file") = "gbil.log" ]
then
    ~/loadrc/gitrc/discard_unnecessaries.sh
    ~/loadrc/gitrc/gbir.sh
    exit 0
fi

if [[ "$file" = *'.leetcode.java' ]] || [[ "$file" = *'.leetcode.py' ]] || [[ "$file" = *'.leetcode.python3.py' ]]
then
    leetcode submit "$file"
    exit 0
fi

if [[ "$file" = *'.php' ]] 
then
    ~/loadrc/imvurc/generate.sh "$file"
    exit 0
fi

extension=${file##*.}
host=$(git config deploy.host)
rpath=$(git config deploy.path)
rootFolder=$(~/loadrc/bashrc/find_up_folder.sh "$file" "files.proj")
rfile=$(realpath --relative-to="$rootFolder" "$file")
rfolder=$(realpath --relative-to="$rootFolder" $(dirname "$file"))

if [[ "$file" = *'Dockerfile' ]] 
then
    cd "$rootFolder"
    docker build -f "$rfile" "$rfolder"
    exit 0
fi

case $extension in
    hs)
        runghc "$file"
        ;;
    sql)
        if [[ -n "$host" ]] && [[ "$host" != "localhost" ]]
        then
            ssh -nY "$host" "~/loadrc/sqlrc/xsql.sh $rpath/$rfile $rpath"
        else
            ~/loadrc/sqlrc/xsql.sh "$file" "$2"
        fi
        ;;
    findresult)
       zsh "$file"
        ;;
    vdiff)
       zsh "$file"
        ;;
    sh)
        if [[ -n "$host" ]] && [[ "$host" != "localhost" ]]
        then
            ssh -nY "$host" "cd $rpath ; . ~/loadrc/.loadrc ; $rpath/$rfile"
        else
            . ~/loadrc/.loadrc
            "$file"
        fi
        ;;
    lsh)
        "$file"
        ;;
    py)
        if [[ -n "$host" ]] && [[ "$host" != "localhost" ]]
        then
            ssh -nY "$host" "cd $rpath ; . ~/loadrc/.loadrc ; python3 $rfile"
        else
            SCRIPT=$(realpath "$file")
            SCRIPTPATH=$(dirname "$SCRIPT")
            cd "$SCRIPTPATH"
            python3 "$file"
        fi
        ;;
    vim)
        source "$file"
        ;;
    yaml)
        if [[ -n "$host" ]] && [[ "$host" != "localhost" ]]
        then
            ssh -nY "$host" "kubectl apply -f $rpath/$rfile"
        else
            kubectl apply -f "$file"
        fi
        ;;
    yml)
        if [[ -n "$host" ]] && [[ "$host" != "localhost" ]]
        then
            ssh -nY "$host" "docker-compose -f $rpath/$rfile up -d"
        else
            docker-compose -f "$file" up -d
        fi
        ;;
    ymldebug)
        docker-compose -f "$file" up --build --force-recreate
        ;;
esac
