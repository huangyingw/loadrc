#!/bin/bash -
rsync -aHv --progress --include="*/" --include="*/6*" --exclude="*" /media/volgrp/mirror/av/ /media/volgrp/zarchive/av/
rsync -aHv --progress --include="*/" --include="*/7*" --exclude="*" /media/volgrp/mirror/av/ /media/volgrp/zarchive/av/
