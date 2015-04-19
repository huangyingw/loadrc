#!/bin/bash
docker run  \
  -v /root:/root \
  -v /media/volgrp/pxe/ubuntu/:/var/www/ubuntu/ \
  -v /media/volgrp/pxe/tftpboot/:/var/lib/tftpboot/ \
  -h pxe \
  -p 80:80 \
  -ti huangyingw/pxe bash

