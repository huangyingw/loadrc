if [ -z "$1" ]
then
    host=`virsh list|awk '/running/{print $2}'`
else
    host="$1"
fi
port=`~/loadrc/kvmrc/vsdx.sh $host |grep vnc|grep -ow '[0-9]\{4\}'`
vncviewer localhost:$port
