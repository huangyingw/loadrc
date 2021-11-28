#!/bin/zsh

dd \
    bs=4M \
    if=/media/volgrp/cubic/ubuntu-21.10.0-2021.11.27-desktop-amd64.iso \
    of=/dev/sda \
    conv=fdatasync \
    status=progress
