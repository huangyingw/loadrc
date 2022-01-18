#!/bin/zsh

if ! (/usr/bin/df -TH /dev/mapper/transmission | /usr/bin/grep -q 100% )
then
    echo "partition is not full yet"
    exit 1
fi

function CountParts()
{
    /usr/bin/find /var/lib/transmission-daemon/ -type f -mtime +"$1" -name \*.part | /usr/bin/wc -l
}

left=1
right=300

while [ $((left + 1)) -lt $right ]
do
    mid=$(printf '%s\n' $left $right | /usr/bin/datamash median 1)
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

if [ $result -gt 0 ]
then
    /usr/bin/find /var/lib/transmission-daemon/ -type f -mtime +$right -name \*.part -delete
else
    /usr/bin/find /var/lib/transmission-daemon/ -type f -mtime +$left -name \*.part -delete 
fi
