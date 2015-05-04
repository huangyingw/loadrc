#!/bin/bash
git rev-list --all | xargs git grep -wnH "$1" > "$1".gsearch.findresult
vi "$1".gsearch.findresult
