#!/bin/zsh

for (( c=1; c<=500; c++ ))
do
    for ip in \
        192.168.31.140 \
        192.168.86.24
    do
        iperf -f MBytes -c $ip >> ~/loadrc/$ip.log
    done
done
