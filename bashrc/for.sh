for ss in `$1`
do
    $2 $ss
done

for ss in \
    str1 \
    str2 \
    str3
do
    echo $ss
done

#echo "for ss in `$1`; do echo $ss; done"
for (( c=1; c<=5; c++ ))
do
    echo "Welcome $c times"
done
