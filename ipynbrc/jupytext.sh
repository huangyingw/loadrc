#!/bin/zsh
find . -type f -name \*.ipynb -exec jupytext --sync {} \;
