#!/bin/bash -
openvpn --config ~/.ssh/client.ovpn --auth-user-pass --auth-retry interact
