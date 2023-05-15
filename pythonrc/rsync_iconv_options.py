#!/usr/bin/env python3

"""
rsync_iconv_options.py
A script to determine the appropriate --iconv option for rsync based on the source and destination encoding.
"""

import sys
import re
import subprocess
from rsync_path_resolver import parse_host


def get_remote_encoding(remote_path):
    remote_host = parse_host(remote_path)
    if remote_host is None:
        raise ValueError(f"Invalid remote path: {remote_path}")
    remote_os = subprocess.check_output(
        [
            "ssh",
            "-o",
            "BatchMode=yes",
            "-o",
            "StrictHostKeyChecking=no",
            remote_host,
            "uname",
        ],
        text=True,
    ).strip()
    if remote_os == "Darwin":
        return "utf-8-mac"
    else:
        return "utf-8"


def generate_iconv_options(source_dir, destination_dir):
    if sys.platform == "darwin":
        local_encoding = "utf-8-mac"
    else:
        local_encoding = "utf-8"

    if re.match(r"^(.*@)?[^:]+:", source_dir):
        src_encoding = get_remote_encoding(source_dir)
    else:
        src_encoding = local_encoding

    if re.match(r"^(.*@)?[^:]+:", destination_dir):
        dst_encoding = get_remote_encoding(destination_dir)
    else:
        dst_encoding = local_encoding

    rsync_options = f"--iconv={src_encoding},{dst_encoding}"
    return rsync_options  # Replace the print statement with a return statement


def main():
    if len(sys.argv) != 3:
        print(
            "Usage: python rsync_iconv_options.py <source_directory> <destination_directory>"
        )
        sys.exit(1)

    source_dir = sys.argv[1]
    destination_dir = sys.argv[2]
    generate_iconv_options(source_dir, destination_dir)


if __name__ == "__main__":
    main()
