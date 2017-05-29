#!/bin/bash -
mdadm --manage /dev/md0 --run
mdadm --manage /dev/md0 --add /dev/sdc
