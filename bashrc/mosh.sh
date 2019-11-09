target=$(echo "$1" | sed  -e "s/\/$//g")
mkdir "$target"
mosh "$target" -- ${tmuxAction}
