#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

deploy_configs() {
	TARGET="$1"
	SOURCE=~/loadrc/"`hostname`$TARGET"

	if [ -f "$SOURCE" ]
	then
		sudo cp -fv "$SOURCE" "$TARGET"
	fi
}

while read -r line || [[ -n "$line" ]]
do
	deploy_configs "$line"
done < host.conf

HOSTTODOS=~/loadrc/"`hostname`/todos.sh"
if [ -f "$HOSTTODOS" ]
then
	"$HOSTTODOS"
fi

sudo launchctl unload /Library/LaunchDaemons/com.zerotier.one.plist
sudo launchctl load /Library/LaunchDaemons/com.zerotier.one.plist
service zerotier-one stop
service zerotier-one start
