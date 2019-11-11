
if [[ "$2" != *":"* ]] && [[ ! -d "$2" ]]
then
    mkdir -p "$2"
fi

SOURCE=`realpath "$1"`
TARGET=`realpath "$2"`

if [ "$SOURCE" != "$TARGET" ]
then
    rsync --remove-source-files -aHSv --progress --force "$1" "$2" \
        && ~/loadrc/bashrc/rmEmpty.sh "$1"
else
    echo -e "${red}same dir --> ${SOURCE} ... ${NC}"
    echo -e "${red}please choose the different dir! ... ${NC}"
    exit 1
fi
