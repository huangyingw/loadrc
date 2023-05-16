#!/usr/bin/env python3

"""
rsync_path_resolver.py
A script to determine the appropriate --rsync-path option for rsync based on the source and target hosts.
"""

import re
import sys
import subprocess
from pathlib import Path


def parse_host(path):
    match = re.match(r"^(([^@]+@)?[^:]+):", path)
    if match:
        return match.group(1)
    return None


def get_rsyncpath(host):
    command = ". ~/loadrc/.pathrc; which rsync"
    if host == "localhost":
        try:
            rsyncpath = subprocess.check_output(
                command, shell=True, text=True
            ).strip()
        except subprocess.CalledProcessError as e:
            print(f"Error while getting rsync path: {e}")
            sys.exit(1)
    else:
        try:
            rsyncpath = subprocess.check_output(
                ["ssh", host, command], text=True
            ).strip()
        except subprocess.CalledProcessError as e:
            print(f"Error while getting rsync path: {e}")
            sys.exit(1)

    return rsyncpath


def resolve_rsync_path(source, target):
    shost = parse_host(source)
    thost = parse_host(target)

    if shost and shost != "localhost":
        rsyncpath = get_rsyncpath(shost)
    elif thost and thost != "localhost":
        rsyncpath = get_rsyncpath(thost)
    else:
        rsyncpath = get_rsyncpath("localhost")

    if rsyncpath:
        return f"--rsync-path={rsyncpath}"
    else:
        return None


def main():
    if len(sys.argv) != 3:
        print("Usage: python rsync_path_resolver.py <source> <target>")
        sys.exit(1)

    source = sys.argv[1]
    target = sys.argv[2]
    rsync_path_option = resolve_rsync_path(source, target)
    print(rsync_path_option)


if __name__ == "__main__":
    main()
