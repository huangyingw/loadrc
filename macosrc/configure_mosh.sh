#!/bin/zsh
BINPATH=$(/usr/local/bin/realpath $(which mosh-server))

# Turn the firewall off
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off

# Enable the firewall rules (make sure you are using your actual path)
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add "$BINPATH"

sudo /usr/libexec/ApplicationFirewall/socketfilterfw --unblockapp "$BINPATH"

# Turn the firewall back on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
