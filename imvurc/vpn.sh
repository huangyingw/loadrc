#!/bin/zsh
openvpn --config ~/.ssh/client.ovpn --auth-user-pass --auth-retry interact
