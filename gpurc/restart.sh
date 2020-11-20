#!/bin/zsh

~/loadrc/gpurc/kill_nvidia.sh
rmmod nvidia_uvm
modprobe nvidia_uvm
