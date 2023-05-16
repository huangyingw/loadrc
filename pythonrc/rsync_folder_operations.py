#!/usr/bin/env python3

"""
rsync_folder_operations.py
A script to move, copy, or mirror the contents of one folder into another using rsync while maintaining the tree structure.
"""

import os
import sys
import subprocess
from rsync_path_resolver import resolve_rsync_path
from rsync_mkpath_decider import decide_mkpath_option
from rsync_iconv_options import generate_iconv_options


def validate_input(mode, source_folder, target_folder):
    if mode not in ["move", "copy", "mirror", "tmirror"]:
        raise ValueError(
            "Invalid mode. Valid modes are 'move', 'copy', 'mirror', and 'tmirror'."
        )

    # Check if source and target are the same for local paths only
    if (":" not in source_folder) and (":" not in target_folder):
        if os.path.samefile(source_folder, target_folder):
            raise ValueError("Source and target folders cannot be the same.")


def get_rsync_options(mode, source_folder, target_folder):
    iconvs = generate_iconv_options(source_folder, target_folder)
    rsync_path_option = resolve_rsync_path(source_folder, target_folder)
    mkpath_option = decide_mkpath_option(target_folder)

    rsync_basic_options_path = os.path.expanduser(
        "~/loadrc/bashrc/rsync_basic_options"
    )
    with open(rsync_basic_options_path, "r") as file:
        rsync_basic_options = file.read().split()

    rsync_options = [
        option
        for option in (
            rsync_basic_options + [iconvs, rsync_path_option, mkpath_option]
        )
        if option
    ]

    if mode == "move":
        rsync_options.append("--remove-source-files")
    elif mode == "mirror":
        rsync_options.append("--delete-before")
    elif mode == "tmirror":
        rsync_options.extend(["-n", "--delete-before"])

    return rsync_options


def execute_rsync(mode, rsync_options, source_folder, target_folder):
    source = f"{source_folder}/"
    target = f"{target_folder}/"

    print("rsync options:", rsync_options)
    print("source:", source)
    print("target:", target)
    if mode == "tmirror":
        ready_file = os.path.join(target_folder, "tmirror.ready")
        with open(ready_file, "w") as outfile:
            subprocess.run(
                ["rsync", "-n", "--delete-before"]
                + rsync_options
                + [source, target],
                stdout=outfile,
            )
    else:
        subprocess.run(["rsync"] + rsync_options + [source, target])


def rsync_operations(source_folder, target_folder, mode):
    # Get the real paths for source and target
    source_folder = os.path.expanduser(source_folder)
    target_folder = os.path.expanduser(target_folder)

    if not (":" in source_folder):
        source_folder = os.path.realpath(source_folder)

    if not (":" in target_folder):
        target_folder = os.path.realpath(target_folder)

    # Add trailing slash if not present
    if not source_folder.endswith("/"):
        source_folder += "/"
    if not target_folder.endswith("/"):
        target_folder += "/"

    validate_input(mode, source_folder, target_folder)
    os.makedirs(target_folder, exist_ok=True)

    rsync_options = get_rsync_options(mode, source_folder, target_folder)
    execute_rsync(mode, rsync_options, source_folder, target_folder)

    return rsync_options


def main():
    if len(sys.argv) != 4:
        print(
            "Usage: python rsync_folder_operations.py source_folder target_folder mode"
        )
        print("mode: 'move', 'copy', 'mirror', or 'tmirror'")
        sys.exit(1)

    source_folder = sys.argv[1]
    target_folder = sys.argv[2]
    mode = sys.argv[3]

    rsync_operations(source_folder, target_folder, mode)


if __name__ == "__main__":
    main()
