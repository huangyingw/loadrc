#!/bin/zsh

# If no argument is provided, use the current directory as target directory.
# Otherwise, use the provided argument as target directory.
TARGETEDIR=${1:-$(realpath "$PWD")}

# Change the working directory to the target directory.
cd "$TARGETEDIR" || exit

# If there is no 'files.proj' file in the target directory, exit the script.
if [ ! -f files.proj ]
then
    echo -e "${red}No files.proj file here, will not build the index ... ${NC}"
    exit 1
fi

# Copy the configuration files from the source to the target directory.
cp -nv ~/loadrc/prunefix_template.conf ./prunefix.conf
cp -nv ~/loadrc/prunefile_template.conf ./prunefile.conf
cp -nv ~/loadrc/includefile_template.conf ./includefile.conf

# Define variables
TARGET=files.proj.tmp
PRUNE_POSTFIX=prunefix.conf
PRUNE_FILE=prunefile.conf
INCLUDE_FILE=includefile.conf

or="";

[ -f "$PRUNE_POSTFIX" ] && while read suf
do
    suf=$(echo "$suf" | sed 's/"//g')
    prune_params+=( $or "-wholename" "$suf" )
    or="-o"
done < "$PRUNE_POSTFIX"

or="";

[ -f "$INCLUDE_FILE" ] && while read suf
do
    suf=$(echo "$suf" | sed 's/"//g')
    include_params+=( $or "-wholename" "$suf" )
    or="-o"
done < "$INCLUDE_FILE"

export LC_ALL=C

# Perform the find operation and output to target file
find . "(" "${prune_params[@]}" ")" -a -prune -o -size +0 -type f -exec grep -Il "" {} + > "$TARGET"

# If include parameters exist, perform additional find operation
if [ ${#include_params[@]} -gt 0 ]; then
    find . "(" "${include_params[@]}" ")" -type f -size -9000k -exec grep -Il "" {} + >> "$TARGET"
fi

# Post-processing
echo "./$(~/loadrc/gitrc/get_current_branch.sh).gdio.diff" >> "$TARGET"
sed -i.bak 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/;s/ /\\ /g' "$TARGET"
comm -23 <(sort "$TARGET") <(sort "$PRUNE_FILE") > "$TARGET.tmp"
cp -fv "$TARGET.tmp" "$TARGET"
sort -u "$TARGET" -o "$TARGET"
cp -fv "$TARGET" files.proj

new_entry=$(echo "$TARGETEDIR/files.proj" | sed 's/\(["'\''\]\)/\\\1/g;s/ /\\ /g;s/.*/"&"/')

# Check if new_entry exists in ~/all.proj, only update if not exists
if ! grep -q -F "$new_entry" ~/all.proj; then
    echo "$new_entry" >> ~/all.proj
    sort -u ~/all.proj -o ~/all.proj.tmp
    cp -fv ~/all.proj.tmp ~/all.proj
fi
