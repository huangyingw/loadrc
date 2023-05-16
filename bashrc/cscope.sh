#!/bin/zsh

SOURCEFILE="cscopesourcefile.bak"
TEMP_CSCOPE_OUT="cscope.out.bak"
TEMP_CSCOPE_IN="cscope.in.out.bak"
TEMP_CSCOPE_PO="cscope.po.out.bak"

# Build the index in temporary files
cp -fv files.proj "$SOURCEFILE" && \
    sed -i.bak 's/\\ / /g' "$SOURCEFILE" && \
    cscope -bq -i "$SOURCEFILE" -f "$TEMP_CSCOPE_OUT" && \
    echo "Temporary cscope index files created successfully."

# Replace the real index files with temporary files
cp -fv "$TEMP_CSCOPE_OUT" cscope.out && \
    cp -fv "$TEMP_CSCOPE_IN" cscope.in.out && \
    cp -fv "$TEMP_CSCOPE_PO" cscope.po.out && \
    echo "Cscope index files updated successfully."

# Clean up the temporary and backup files
rm -f "$SOURCEFILE.bak" "$TEMP_CSCOPE_OUT" "$TEMP_CSCOPE_IN" "$TEMP_CSCOPE_PO"
