#!/bin/zsh

function CountParts()
{
    echo $(find /var/lib/transmission-daemon/ -type f -mtime +"$1" -name \*.part | wc -l)
}

left=1
right=30

while [ $left -lt $right ]
do
    mid=$(printf '%s\n' $left $right | datamash median 1)
    mid=${mid%.*}
    echo "mid --> $mid"

    local result=$(CountParts $mid)
    result=${result%.*}
    echo "result --> $result"

    if [ $result -gt 0 ]
    then
        left=$((mid + 1))
        echo "left --> $left"
    else
        right=$mid
        echo "right --> $right"
    fi
done

echo "find /var/lib/transmission-daemon/ -type f -mtime +$mid -name \*.part | wc -l"
echo "find /var/lib/transmission-daemon/ -type f -mtime +$left -name \*.part | wc -l"
echo "find /var/lib/transmission-daemon/ -type f -mtime +$right -name \*.part | wc -l"
