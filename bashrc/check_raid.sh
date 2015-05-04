#!/bin/bash
CHECKFILE=/media/volgrp/to_check_raid
if ! [ -f "$CHECKFILE" ]; then
  return
fi
DEVICE=`mdadm -D --scan|awk '{print $2}'`
raid_count=`mdadm -D $DEVICE |grep "active sync"|wc -l`
if [ $raid_count -lt 4 ] 
then   
  echo dangerous
  echo dangerous
  echo dangerous
else
  echo success
  echo success
  echo success
fi
