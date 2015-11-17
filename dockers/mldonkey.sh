#!/bin/bash
docker run  \
  -v /root:/root \
  -v /media/volgrp/mldonkey/:/var/lib/mldonkey/ \
  -h mldonkey \
  -ti huangyingw/mldonkey bash
