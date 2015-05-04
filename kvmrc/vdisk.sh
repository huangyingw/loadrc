#!/bin/bash
TARGET=`echo "$1" |sed 's/\.qcow2//g'`
qemu-img create -f qcow2 "$TARGET".qcow2  1000G
