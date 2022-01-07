#!/bin/zsh
BINPATH=$(realpath $(which mosh-server))

# Turn the firewall off
/usr/bin/sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off

# Enable the firewall rules (make sure you are using your actual path)
/usr/bin/sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add "$BINPATH"

/usr/bin/sudo /usr/libexec/ApplicationFirewall/socketfilterfw --unblockapp "$BINPATH"

# Turn the firewall back on
/usr/bin/sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
