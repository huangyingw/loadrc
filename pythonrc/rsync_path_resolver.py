#!/usr/bin/env python3

"""
rsync_path_resolver.py
A script to determine the appropriate --rsync-path option for rsync based on the source and target hosts.
"""

import sys
import subprocess
from pathlib import Path


def parse_host(path):
    if ":" in path:
        return path.split(":", 1)[0]
    else:
        return "localhost"


def get_rsyncpath(host):
    if host == "localhost":
        return "/usr/bin/rsync"
    else:
        return subprocess.check_output(
            ["ssh", host, ". ~/loadrc/.pathrc; which rsync"], text=True
        ).strip()


def resolve_rsync_path(source, target):
    shost = parse_host(source)
    thost = parse_host(target)

    if shost != "localhost":
        rsyncpath = get_rsyncpath(shost)
    elif thost != "localhost":
        rsyncpath = get_rsyncpath(thost)
    else:
        rsyncpath = get_rsyncpath("localhost")

    return f"--rsync-path={rsyncpath}"


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
