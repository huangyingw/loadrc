#!/bin/bash
for ss in `$1`; do $2 $ss; done
#echo "for ss in `$1`; do echo $ss; done"
for (( c=1; c<=5; c++ ))
do
    echo "Welcome $c times"
done
