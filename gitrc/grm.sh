#!/bin/bash
git rm --cached "$1" && echo "$1" >> .gitignore
