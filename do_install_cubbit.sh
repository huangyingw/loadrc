#!/bin/bash

set -e

function clog
{
    echo "${BLUE}${UNDERLINE}$1${RESET}"
}

function cerror
{
    echo "${RED}${UNDERLINE}$1${RESET}"
}

function titlize
{
	echo "${YELLOW}$1${RESET}"
}

######## COLORS ########
YELLOW=`tput setaf 3`
BLUE=`tput setaf 4`
RED=`tput setaf 1`
UNDERLINE=`tput smul`
RESET=`tput sgr0`
######## END COLORS ########

base_url="https://get.cubbit.io/desktop/linux"
default_file_manager=`xdg-mime query default inode/directory | tr '[:upper:]' '[:lower:]'`

clog "[3.1] Detecting default file manager"
if [[ $default_file_manager = *"nemo"* ]]; then
    file_manager="nemo"
elif [[ $default_file_manager = *"nautilus"* ]]; then
    file_manager="nautilus"
elif [[ $default_file_manager = *"caja"* ]]; then
    file_manager="caja"
else
    cerror "File manager not supported"
    file_manager="skip"
fi

if [[ $file_manager != "skip" ]]; then

	clog "[3.2] File manager detected: $file_manager. Downloading and installing dependencies"

	sudo apt-get update -y &>/dev/null
	sudo apt-get install -y libappindicator1 &>/dev/null

	if [ $(apt-cache search python3-$file_manager | wc -l) -ne 0 ]; then
		sudo apt-get install -y python3-$file_manager &>/dev/null
	else
		sudo apt-get install -y python-$file_manager &>/dev/null
	fi

	tmp_dir=$(mktemp -d -t cubbit-XXXXXX)
	wget "$base_url/deps.tar.gz" -O "$tmp_dir/deps.tar.gz" &>/dev/null
	tar xf "$tmp_dir/deps.tar.gz" -C "$tmp_dir"

	capitalized_file_manager="$(tr '[:lower:]' '[:upper:]' <<< ${file_manager:0:1})${file_manager:1}"
	assets_dir="$tmp_dir/deps/assets"

	clog "[3.3] Copying extension icons"
	for icon_size in `ls $assets_dir`; do
		sudo cp $assets_dir/$icon_size/* /usr/share/icons/hicolor/$icon_size/emblems/
	done
	sudo gtk-update-icon-cache /usr/share/icons/hicolor/ &>/dev/null

	clog "[3.4] Installing $file_manager extension"
	sudo cp $tmp_dir/deps/CubbitExtension.py /usr/share/$file_manager-python/extensions/CubbitExtension.py
	rm -rf $tmp_dir &>/dev/null
	sudo sed -i.org -e "s/Nemo/$capitalized_file_manager/g" /usr/share/$file_manager-python/extensions/CubbitExtension.py

	while [[ $selection != "Y" ]] && [[ $selection != "y" ]] && [[ $selection != "n" ]] && [[ $selection != "N" ]]; do
		read -p "File manager need to be restarted in order to enable Cubbit sync extension. Do you want to restart it now? [Y/n]" "selection"
		if [[ $selection == "Y" ]] || [[ $selection == "y" ]] || [[ -z $selection ]]; then
			(killall $file_manager || true) &>/dev/null
			selection="Y"
		elif [[ $selection == "n" ]] || [[ $selection == "N" ]]; then
			echo "In order to enable Cubbit sync extension you need to manually restart $file_manager (e.g. killall $file_manager)"
		fi
	done
else
	clog "Your file manager ($default_file_manager) is not currently supported by Cubbit."
	clog "Do you want to install Cubbit anyways?"
	select yn in "Yes" "No"; do
		case "$yn" in
			Yes ) break;;
			No ) exit;;
		esac
	done
fi

cubbit_latest=$(curl -qs https://cubbit.s3.eu-central-1.amazonaws.com/desktop/linux/latest-linux.yml | grep path | awk '{split($0,a," "); print a[2]}')
download_folder=$(xdg-user-dir DOWNLOAD)

clog "[3.5] Downloading appImage in $download_folder"

cd $download_folder &>/dev/null
rm -f $cubbit_latest &>/dev/null
curl -# -A "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:54.0) Gecko/20100101 Firefox/54.0" -O -J "$base_url/$cubbit_latest"
sudo chmod +x $cubbit_latest
cd - &>/dev/null
xdg-open $download_folder &>/dev/null
clog "[✓] Cubbit desktop client downloaded into your 'Downloads' folder!"
