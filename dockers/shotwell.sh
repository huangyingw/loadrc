#!/bin/bash
docker run  \
  -v /root:/root \
  -v /media/volgrp/myproject:/media/volgrp/myproject \
  -h shotwell \
  -ti shotwell bash
