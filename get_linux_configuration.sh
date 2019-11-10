SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

get_configs() {
    SOURCE="$1"
    TARGET=~/loadrc/"$SOURCE"
    mkdir -p "$(dirname $TARGET)"
    cp -v "$SOURCE" "$TARGET"
}

while read -r line || [ -n "$line" ]
do
    get_configs "$line"
done < linux.conf
