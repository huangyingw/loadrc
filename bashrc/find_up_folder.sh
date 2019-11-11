
path="$1"

while [[ "$path" != "" && ! -e "$path/$2" ]]
do
    path=${path%/*}
done

echo "$path"
