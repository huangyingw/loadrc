#!/bin/bash
OUTPUT="gvdf.findresult"
if [ -n "$1" ]
then
    if [ -n "$2" ]
    then
        git diff --name-status "$1" "$2" | tee "$OUTPUT"
    else
        git diff --name-status HEAD "$1" | tee "$OUTPUT"
    fi
else
    if [ -z "$(git status --porcelain)" ]
    then
        git diff --name-status `git log --oneline|awk 'NR==2{print $1}'` | tee "$OUTPUT"
    else
        git diff --name-status | tee "$OUTPUT"
    fi
fi

branch=$(echo $1 | sed  -e "s/\//\\\\\//g")
sed -i.bak "s/\b[AMT]\b/git checkout $branch -- /g" "$OUTPUT"
sed -i.bak "s/\bD\b/git rm/g" "$OUTPUT"
sed -i.bak "s/^R[0-9]*/git mv/g" "$OUTPUT"
~/loadrc/gitrc/include_gitconfig.sh
for ss in $(git config --get-all gdif.ignore)
do
    ss=$(echo $ss | sed  -e "s/\//\\\\\//g")
    sed -i.bak "/$ss/d" "$OUTPUT"
done

sort -u "$OUTPUT" -o "$OUTPUT"
