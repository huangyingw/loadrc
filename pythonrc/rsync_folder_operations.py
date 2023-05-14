"""
rsync_folder_operations.py
A script to move, copy, or mirror the contents of one folder into another using rsync while maintaining the tree structure.
"""

import os
import sys
import subprocess
from pathlib import Path
from rsync_path_resolver import resolve_rsync_path
from rsync_mkpath_decider import decide_mkpath_option
from rsync_iconv_options import generate_iconv_options


def rsync_operations(source_folder, target_folder, mode):
    # Get the real paths for source and target
    source_folder = os.path.realpath(source_folder)
    target_folder = os.path.realpath(target_folder)

    if os.path.samefile(source_folder, target_folder):
        print(
            "Source and target folders are identical or just soft links to each other. Aborting."
        )
        return 1

    # Get necessary parameters for rsync
    iconvs = generate_iconv_options(source_folder, target_folder)
    rsync_path_option = resolve_rsync_path(source_folder, target_folder)
    mkpath_option = decide_mkpath_option(source_folder, target_folder)

    with open("./rsync_basic_options", "r") as file:
        rsync_basic_options = file.read().split()

    # Set rsync options based on the mode (move, copy, mirror, or tmirror)
    rsync_options = rsync_basic_options + [
        iconvs,
        rsync_path_option,
        mkpath_option,
    ]
    if mode == "move":
        rsync_options.append("--remove-source-files")
    elif mode == "mirror":
        rsync_options.append("--delete-before")
    elif mode == "tmirror":
        rsync_options.extend(["-in", "--delete-before"])

    print(f"rsync options: {rsync_options}")

    if mode == "tmirror":
        ready_file = os.path.join(source_folder, "tmirror.ready")
        with open(ready_file, "w") as outfile:
            subprocess.run(
                ["rsync"]
                + rsync_options
                + [f"{source_folder}/", f"{target_folder}/"],
                stdout=outfile,
            )
    else:
        subprocess.run(
            ["rsync"]
            + rsync_options
            + [f"{source_folder}/", f"{target_folder}/"]
        )


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
