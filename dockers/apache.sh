#!/bin/bash
docker run  \
  -v /root:/root \
  -v /media/volgrp:/media/volgrp \
  -v /media/samba/Users/huangyingw/Dropbox/apache2:/etc/apache2 \
  -v /media/samba/Users/huangyingw/Dropbox/tos:/var/www/python/tos \
  -h apache \
  -p 80:80 \
  -ti huangyingw/apache bash
