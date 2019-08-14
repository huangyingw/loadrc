#!/bin/bash
file="$1"

if [ $(basename "$file") == "gbil.log" ]
then
    ~/loadrc/gitrc/gbir.sh
    exit 0
fi

if [[ $(git config leetcode.submit) == "true" ]]  && ([[ "$file" = *'.java' ]] || [[ "$file" = *'.py' ]])
then
    leetcode submit "$file"
    exit 0
fi

extension=${file##*.}
host=$(git config deploy.host)
path=$(git config deploy.path)
rootFolder=$(~/loadrc/bashrc/find_up_folder.sh "$1" "files.proj")
rfile=$(realpath --relative-to="$rootFolder" "$1")

case $extension in
    hs)
        runghc "$1"
        ;;
    sql)
        if [[ -n "$host" ]] && [[ "$host" != "localhost" ]]
        then
            ssh -nY "$host" "cd $path ; ~/loadrc/sqlrc/xsql.sh $rfile"
        else
            ~/loadrc/sqlrc/xsql.sh "$1" "$2"
        fi
        ;;
    findresult)
        sh "$1"
        ;;
    vdiff)
        sh "$1"
        ;;
    sh)
        if [[ -n "$host" ]] && [[ "$host" != "localhost" ]]
        then
            ssh -nY "$host" ". ~/loadrc/.loadrc ; $path/$rfile"
            rsync -aHv --force --progress \
                --files-from=files.rev \
                "$host:$path/" \
                .
                        else
                            bash "$1"
                        fi
                        ;;
                    py)
                        if [[ -n "$host" ]] && [[ "$host" != "localhost" ]]
                        then
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
                        if [[ -n "$host" ]] && [[ "$host" != "localhost" ]]
                        then
                            ssh -nY "$host" "docker-compose -f $path/$rfile up -d"
                        else
                            docker-compose -f "$file" up -d
                        fi
                        ;;
                    ymldebug)
                        docker-compose -f "$file" up --build --force-recreate
                        ;;
                esac
