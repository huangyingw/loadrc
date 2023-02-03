#!/bin/zsh
#reactivate array
mdadm --stop /dev/md0
mdadm --assemble --force /dev/md0 /dev/sd[b-e]1
