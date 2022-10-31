#!/bin/zsh
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

a=0
for d in `seq 1 2 7`
do
    ((a++))
    echo $a
done

function copyFiles() {
    arr=("$@")
    for i in "${arr[@]}";
    do
        echo "$i"
    done

}

array=("one 1" "two 2" "three 3")

copyFiles "${array[@]}"
