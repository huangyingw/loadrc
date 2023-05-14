#!/usr/bin/env python3

import sys
import subprocess
import re
from typing import Tuple


def get_rsync_version_command() -> str:
    return "rsync --version | head -n 1 | awk '{print $3}'"


def get_rsync_version(host_info: str) -> str:
    host = host_info.split(":", 1)[0]
    cmd = get_rsync_version_command()

    if not host or ":" not in host_info:
        rsync_version = subprocess.check_output(
            cmd, shell=True, text=True
        ).strip()
    else:
        rsync_version = subprocess.check_output(
            f"ssh {host} {cmd}", shell=True, text=True
        ).strip()

    return rsync_version


def check_rsync_version(rsync_version: str) -> bool:
    return tuple(map(int, rsync_version.split("."))) >= (3, 2, 0)


def decide_mkpath_option(source_folder: str, target_folder: str) -> str:
    source_rsync_version = get_rsync_version(source_folder)
    target_rsync_version = get_rsync_version(target_folder)

    if check_rsync_version(source_rsync_version) and check_rsync_version(
        target_rsync_version
    ):
        return "--mkpath"
    else:
        return ""


def main(args: Tuple[str, str]) -> None:
    source_folder, target_folder = args
    mkpath_option = decide_mkpath_option(source_folder, target_folder)
    print(mkpath_option)


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print(f"Usage: {sys.argv[0]} source_folder target_folder")
        sys.exit(1)

    main(tuple(sys.argv[1:]))
