#!/bin/bash
docker run \
  -v /media/volgrp:/media/volgrp \
  -d \
  -p 8080:8080 \
  -h amb0.mycorp.kom \
  sequenceiq/ambari \
  --tag ambari-server=true
