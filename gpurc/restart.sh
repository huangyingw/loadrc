#!/bin/zsh

kill -9 $(lsof -t /dev/nvidia0)
rmmod nvidia_uvm
modprobe nvidia_uvm
