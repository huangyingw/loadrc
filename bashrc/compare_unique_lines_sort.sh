#!/bin/zsh

# Check if the correct number of arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <file1> <file2>"
    exit 1
fi

# Assign command line arguments to variables
file1="$1"
file2="$2"

# Check if the input files exist
if [ ! -f "$file1" ] || [ ! -f "$file2" ]; then
    echo "Error: One or both input files do not exist."
    exit 1
fi

# Set the locale for consistent sorting and string comparison
export LC_ALL=C

# Find lines unique to file1 and store them in a temporary file
temp1=$(mktemp)
comm -23 <(sort "$file1") <(sort "$file2") >"$temp1"

# Find lines unique to file2 and store them in a temporary file
temp2=$(mktemp)
comm -13 <(sort "$file1") <(sort "$file2") >"$temp2"

# Overwrite the input files with the new unique lines
cp -fv "$temp1" "$file1"
cp -fv "$temp2" "$file2"

# Remove the temporary files
rm -f "$temp1" "$temp2"
