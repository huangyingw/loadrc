#!/bin/bash -
COMMAND="$2 $(<$1)"
eval "$COMMAND"
