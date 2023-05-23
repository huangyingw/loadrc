#!/usr/bin/env python3

# gdit.py

import subprocess
import os
import sys
import re
from configparser import ConfigParser


def execute_command(cmd):
    output, error = subprocess.Popen(
        cmd,
        universal_newlines=True,
        shell=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    ).communicate()
    return output, error, output == ""


def get_git_config(key):
    output, error, failed = execute_command(f"git config {key}")
    if failed:
        return None
    return output.strip()


def git_sync(output):
    current_branch = execute_command("~/loadrc/gitrc/get_current_branch.sh")[
        0
    ].strip()
    target_branch = re.sub(r"\.fix$", "", current_branch)
    remote = get_git_config("gsync.remote")
    target = get_git_config("gsync.target")

    execute_command(f"git branch {target_branch} {target}")
    execute_command(f"git fetch {remote} {target_branch}:{target_branch}")

    remote_branch = re.sub(f"^{remote}/", "", target)
    execute_command(f"git fetch {remote} {remote_branch}:{target_branch}")

    _, _, failed = execute_command(
        f"~/loadrc/gitrc/gdi.sh {target_branch} {current_branch} gdit > {output} 2>&1"
    )

    if failed:
        with open(output, "w") as f:
            f.write("most probably sth wrong in git merge...")
        return

    remote = get_git_config("gdi2.remote")
    execute_command(f"git push {remote} {target_branch}")


if __name__ == "__main__":
    git_sync(sys.argv[1])
