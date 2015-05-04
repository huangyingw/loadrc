#!/bin/bash
while read ss
do
  hardseed --saveas-path /media/volgrp/av/seed/ --concurrent-tasks 16 --topics-range 1024 --av-class $ss --timeout-download-picture 320 --proxy ""
done < ~/bashrc/hardseed.findresult
