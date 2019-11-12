#!/bin/bash
qemu-img create -f qcow2 /root/kvm/"$1"/"$1".qcow2 500G
