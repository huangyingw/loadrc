#!/bin/bash - 
git branch -a --contains $(git rev-parse HEAD) |grep -v detached
