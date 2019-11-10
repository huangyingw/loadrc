IFS=$'\r\n' GLOBIGNORE='*' command eval  'LINES=($(cat $1))'

for index in "${!LINES[@]}"
do
    for ((next = $index + 1; next < ${#LINES[@]}; next++));
    do
        one=$(echo "${LINES[$index]}" | sed 's/"//g')
        two=$(echo "${LINES[$next]}" | sed 's/"//g')
        kdiff3 "$one" "$two"
    done
done
