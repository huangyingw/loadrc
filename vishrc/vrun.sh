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
    ~/loadrc/leetcoderc/handle.sh "$file"
    exit 0
fi

extension=${file##*.}
host=$(git config deploy.host)
rpath=$(git config deploy.path)
rootFolder=$(~/loadrc/bashrc/find_up_folder.sh "$file" "files.proj")
# Use python3 to get the relative path instead of realpath
rfile=$(python3 -c "import os.path; print(os.path.relpath('$file', '$rootFolder'))" | sed 's/ /\\ /g')
rfolder=$(python3 -c "import os.path; print(os.path.relpath('$(dirname "$file")', '$rootFolder'))" | sed 's/ /\\ /g')

if [[ "$file" = *'_test.py' ]]
then
    cd "$rootFolder"
    pytest $file
    exit 0
fi

if [[ "$file" = *'Dockerfile'* ]]
then
    cd "$rootFolder"
    docker build -f "$rfile" "$rfolder"
    exit 0
fi

if [[ $(basename "$file") = 'Vagrantfile' ]]
then
    cd "$rfolder"
    vagrant reload
    vagrant up
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
    bak)
        zsh "$file"
        ;;
    findresult)
        zsh "$file"
        ;;
    vdiff)
        zsh "$file"
        ;;
    sh|zsh)
        if [[ -n "$host" ]] && [[ "$host" != "localhost" ]]
        then
            ssh -nY "$host" "cd $rpath ; . ~/loadrc/.pathrc ; $rpath/$rfile"
        else
            "$file"
        fi
        ;;
    lsh)
        "$file"
        ;;
    py)
        if [[ -n "$host" ]] && [[ "$host" != "localhost" ]]
        then
            ssh -nY "$host" "cd $rpath ; . ~/loadrc/.pathrc ; python3 $rfile"
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
            ssh -nY "$host" "docker-compose -f $rpath/$rfile up -d --build"
        else
            docker-compose -f "$file" up -d --build
        fi
        ;;
    ymldebug)
        docker-compose -f "$file" up --build --force-recreate
        ;;
    js)
        node "$file"
        ;;
    ps1)
        cd "$rootFolder"
        pwsh "$file"
        ;;
    sln)
        cd "$rootFolder"
        dotnet build "$file"
        ;;
    cs|csproj)
        SCRIPT=$(realpath "$file")
        SCRIPTPATH=$(dirname "$SCRIPT")
        cd "$SCRIPTPATH"
        dotnet build
        dotnet run
        ;;
    go)
        go run "$file"
        ;;
esac
