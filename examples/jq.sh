#!/bin/zsh

az storage account list \
    -g "$resourcegroup" \
    | jq --arg v "$1" '.[] | select(.name|test($v)) | .name'
