#!/bin/zsh

az storage account list \
    -g "$resourcegroup" \
    | jq --arg v "$resourcegroup" '.[] | select(.name|test($v)) | .name'
