#!/bin/zsh

ps ax | grep -v grep | grep nvidia-smi | awk '{print $1}' | xargs -n1 kill -9
nvidia-smi | awk '/python/{print $5}' | xargs -n1 kill -9
rmmod nvidia_uvm
modprobe nvidia_uvm
