#!/bin/bash
file="$1"

if [ $(basename "$file") == "gbil.findresult" ]
then
    ~/loadrc/gitrc/gbir.sh
    exit 0
fi

extension=${file##*.}
host=$(git config deploy.host)
path=$(git config deploy.path)

case $extension in
    hs)
        runghc "$1"
        ;;
    sql)
        if [[ -n "$host" ]] && [[ "$host" != "localhost" ]]
        then
            rootFolder=$(~/loadrc/bashrc/find_up_folder.sh "$1" "files.proj")
            rfile=$(realpath --relative-to="$rootFolder" "$1")
            ssh -nY "$host" "cd $path ; ~/loadrc/sqlrc/xsql.sh $rfile"
        else
            ~/loadrc/sqlrc/xsql.sh "$1" "$2"
        fi
        ;;
    rsql)
        ;;
    findresult)
        sh "$1"
        ;;
    vdiff)
        sh "$1"
        ;;
    ash)
        bash "$1"
        ;;
    sh)
        bash "$1"
        ;;
    rsh)
        rootFolder=$(~/loadrc/bashrc/find_up_folder.sh "$1" "files.proj")
        rfile=$(realpath --relative-to="$rootFolder" "$1")
        ssh -nY "$host" "$path/$rfile"
        rsync -aHv --force --progress \
            --files-from=files.rev \
            "$host:$path/" \
            .
        ;;
    py)
        if [[ -n "$host" ]] && [[ "$host" != "localhost" ]]
        then
            rootFolder=$(~/loadrc/bashrc/find_up_folder.sh "$1" "files.proj")
            rfile=$(realpath --relative-to="$rootFolder" "$1")
            ssh -nY "$host" "cd $path ; . ~/loadrc/.loadrc ; python $rfile"
        else
            SCRIPT=$(realpath "$1")
            SCRIPTPATH=$(dirname "$SCRIPT")
            cd "$SCRIPTPATH"
            python "$1"
        fi
        ;;
    vim)
        source "$1"
        ;;
    yml)
        docker-compose -f "$file" up -d
        ;;
    ymldebug)
        docker-compose -f "$file" up --build --force-recreate
        ;;
esac

if [[ $(git config leetcode.submit) == "true" ]]  && ([[ "$file" = *'.java' ]] || [[ "$file" = *'.py' ]])
then
    leetcode submit "$file"
fi
