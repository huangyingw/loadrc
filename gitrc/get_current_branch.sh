#!/bin/bash -
echo git branch | awk '/^\*/{print $2}'
