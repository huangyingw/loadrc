#!/bin/bash
git pull $(git config gsync.remote) $(git config gsync.branch)
