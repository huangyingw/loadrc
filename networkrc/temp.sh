ifconfig wlan0 down
ping -c 1 8.8.8.8
rc=$?

if [[ $rc -eq 0 ]] ; then
    echo "network is working"
else
    echo "network is not working"
fi
