SOURCE=$1
TARGET=$2

if [ -L ${1%/} ] || [ -L ${2%/} ]
then
    echo -e "${red}please not use simbo link ! ... ${NC}"
    exit 1
fi

if [ -f "$TARGET" ]
then
    echo -e "${red}Please consider backup/move the target folder --> $TARGET first ! ... ${NC}"
    exit 1
fi

LNSOURCE=`echo $SOURCE | sed 's/\/$//'`

~/loadrc/bashrc/move.sh "$SOURCE" "$TARGET"
ln -fs "$TARGET" "$LNSOURCE"
