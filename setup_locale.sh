#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

LOCALE="en_US.UTF-8"
echo "locales locales/default_environment_locale select $LOCALE" | debconf-set-selections
echo "locales locales/locales_to_be_generated multiselect $LOCALE UTF-8" | debconf-set-selections
rm "/etc/locale.gen"
dpkg-reconfigure --frontend noninteractive locales
