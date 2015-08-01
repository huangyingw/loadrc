#!/bin/bash
docker run  \
  -v /root:/root \
  -v /media/volgrp:/media/volgrp \
  -h vim \
  -ti vim bash
