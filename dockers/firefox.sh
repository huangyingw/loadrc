#!/bin/bash
docker run  \
  -v /root:/root \
  -v /media/volgrp/pxe/ubuntu/:/var/www/ubuntu/ \
  -v /media/volgrp/ubuntu/dists/utopic-updates/main/installer-amd64/current/images/netboot/:/var/lib/tftpboot/ \
  -h pxe \
  -p 69:69/udp \
  -p 80:80 \
  -ti huangyingw/pxe bash


