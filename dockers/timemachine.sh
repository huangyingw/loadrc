#!/bin/bash
sudo docker run -e PASSWORD=asdf -v /media/volgrp/timemachine/:/backup -p 548:548 --net=host -d arve0/timemachine
