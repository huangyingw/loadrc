#!/bin/zsh
find . -type f -name \*.ipynb -exec jupytext --set-formats ipynb,py {} \;
