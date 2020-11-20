#!/bin/zsh

kill -9 $(lsof -t /dev/nvidia0)
