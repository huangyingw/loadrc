#!/bin/bash -
find dogscats/ -type d -print | sed 's/dogscats/smallset/g' | xargs mkdir -p
