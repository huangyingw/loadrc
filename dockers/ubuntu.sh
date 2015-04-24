#!/bin/bash
docker run  \
  -v /root:/root \
  -v /media/volgrp:/media/volgrp \
  -h ubuntu \
  -ti ubuntu bash
