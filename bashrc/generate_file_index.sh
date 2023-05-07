#!/bin/zsh

# Check if a directory is provided as an argument, otherwise use the current directory
if [ -z "$1" ]; then
    TARGET_DIR=$(realpath "$PWD")
else
    TARGET_DIR=$(realpath "$1")
fi

cd "$TARGET_DIR"

# Check for the existence of files.proj file
if [ ! -f files.proj ]; then
    echo -e "${red}No files.proj file here, will not build the index ... ${NC}"
    exit 1
fi

# Copy the necessary configuration files
cp -nv ~/loadrc/prunefix_template.conf ./prunefix.conf
cp -nv ~/loadrc/prunefile_template.conf ./prunefile.conf
cp -nv ~/loadrc/includefile_template.conf ./includefile.conf

# Set variables
TARGET=files.proj.tmp
PRUNE_POSTFIX=prunefix.conf
PRUNE_FILE=prunefile.conf
INCLUDE_FILE=includefile.conf

# Read the prune postfix configuration
or=""
[ -f "$PRUNE_POSTFIX" ] && while read suf; do
suf=$(echo "$suf" | sed 's/"//g')
prune_params+=( $or "-wholename" "$suf" )
or="-o"
done < "$PRUNE_POSTFIX"

# Read the include file configuration
or=""
[ -f "$INCLUDE_FILE" ] && while read suf; do
suf=$(echo "$suf" | sed 's/"//g')
include_params+=( $or "-wholename" "$suf" )
or="-o"
done < "$INCLUDE_FILE"

export LC_ALL=C

# Find and process files, combining prune and include operations
find . "(" "${prune_params[@]}" ")" -a -prune -o -type f "(" -size +0 -o "${include_params[@]}" ")" -exec grep -Il "" {} + > "$TARGET"

# Post-processing
echo "./$(~/loadrc/gitrc/get_current_branch.sh).gdio.diff" >> "$TARGET"
sed -i.bak 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/;s/ /\\ /g' "$TARGET"
comm -23 <(sort "$TARGET") <(sort "$PRUNE_FILE") > "$TARGET.tmp"
cp -fv "$TARGET.tmp" "$TARGET"
sort -u "$TARGET" -o "$TARGET"
cp -fv "$TARGET" files.proj
new_entry="$(echo "$TARGET_DIR"/files.proj | sed 's/\(["'\''\]\)/\\\1/g;s/ /\\ /g;s/.*/"&"/')"

# Check if new_entry exists in ~/all.proj, only update if not exists
if ! grep -q -F "$new_entry" ~/all.proj; then
    echo "$new_entry" >> ~/all.proj
    sort -u ~/all.proj -o ~/all.proj.tmp
    cp -fv ~/all.proj.tmp ~/all.proj
fi
