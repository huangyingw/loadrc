#!/bin/zsh

function CountParts()
{
    echo $(find /var/lib/transmission-daemon/ -type f -mtime +"$1" -name \*.part | wc -l)
}

left=1
right=30

while [ $((left + 1)) -lt $right ]
do
    mid=$(printf '%s\n' $left $right | datamash median 1)
    mid=${mid%.*}
    echo "mid --> $mid"

    local result=$(CountParts $mid)
    result=${result%.*}
    echo "result --> $result"

    if [ $result -gt 0 ]
    then
        left=$mid
        echo "left --> $left"
    else
        right=$mid
        echo "right --> $right"
    fi
done

local result=$(CountParts $right)
result=${result%.*}
echo "result --> $result"

if [ $result -gt 0 ]
then
    find /var/lib/transmission-daemon/ -type f -mtime +$right -name \*.part -delete
else
    find /var/lib/transmission-daemon/ -type f -mtime +$left -name \*.part -delete 
fi