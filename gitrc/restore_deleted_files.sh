#!/bin/bash
# 脚本用于恢复Git中被删除的文件

git ls-files --deleted | xargs git checkout
