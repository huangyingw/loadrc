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
            python "$file"
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
        shFiles=$(ls *.sh 2>/dev/null | wc -l)
        if [ "$shFiles" -eq 1 ]; then
            sh *.sh
        else
            go run .
        fi
        ;;
    puml)
        # Python 程序的完整路径
        PROGRAM_PATH="$HOME/myproject/git/system_design/plantumlmacviewer/PlantUMLMacViewer.py"

        # 套接字服务器的地址和端口
        SOCKET_HOST="localhost"
        SOCKET_PORT=12345

            # 检查程序是否已经运行
            if ! pgrep -f $PROGRAM_PATH > /dev/null 2>&1
            then
                # 如果程序没有运行，使用 nohup 在后台启动程序
                nohup python "$PROGRAM_PATH" > "$HOME/PlantUMLMacViewer.log" 2>&1 &
                echo "PlantUMLMacViewer.py 启动了。"
                sleep 1  # 等待一秒以确保程序已启动
            fi

        # 使用 nc 发送文件路径到套接字服务器
        echo -e "$file" | nc $SOCKET_HOST $SOCKET_PORT
        echo "文件路径已发送到套接字服务器。"
        # 切换焦点回 iTerm
        osascript -e 'tell application "iTerm" to activate'
        ;;
esac
