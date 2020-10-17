#!/bin/zsh 
dd if=/dev/nbd0 | pv | dd of=/dev/nbd0
