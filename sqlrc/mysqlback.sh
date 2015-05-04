#!/bin/sh
HOST="$1"
TARGET="$2"
mysqldump -ucondor -ptemp123 -h"$HOST" recdeveloper > "$TARGET"
