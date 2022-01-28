#!/bin/zsh

file=$(realpath "$1")
target="$1.lsh"

if [ ! -f "$target" ]
then
    cp -nv ~/loadrc/imvurc/generate_sh.template "$target"
    rootFolder=$(~/loadrc/bashrc/find_up_folder.sh "$file" "files.proj")
    relative_path=$(realpath --relative-to="$rootFolder" "$file")
    relative_path=$(echo "$relative_path" | sed 's/\//\\\//g')
    sed -i.bak "s/relative_path_var/$relative_path/g" "$target"
fi
