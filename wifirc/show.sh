#!/bin/bash - 
PHY=$(iw list | awk '/Wiphy/{print $2}')
iw "$PHY" wowlan show
