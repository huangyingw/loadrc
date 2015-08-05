#!/bin/bash
docker run  \
  -v /root:/root \
  -v /media/samba/Users/huangyingw/myproject:/media/volgrp/myproject \
  -h eclipse \
  -ti eclipse bash
