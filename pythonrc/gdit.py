#!/usr/bin/env python3

# gdit.py

import subprocess
import sys
import re
from configparser import ConfigParser


def execute_command(command):
    process = subprocess.Popen(
        command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True
    )
    stdout, stderr = process.communicate()
    return (
        stdout.decode("utf-8").strip(),
        stderr.decode("utf-8").strip(),
        process.returncode,
    )


def get_git_config(key):
    config = ConfigParser()
    config.read([".git/config"])
    if "." in key:
        section, option = key.split(".")
        return (
            config.get(section, option)
            if config.has_option(section, option)
            else None
        )
    return None


def git_sync(output):
    current_branch_command = "~/loadrc/gitrc/get_current_branch.sh"
    current_branch, _, _ = execute_command(current_branch_command)

    target_branch = re.sub(r"\.fix$", "", current_branch)

    remote = get_git_config("gsync.remote")
    target = get_git_config("gsync.target")

    execute_command(f"git branch {target_branch} {target}")
    execute_command(f"git fetch {remote} {target_branch}:{target_branch}")

    remote_branch = re.sub(f"^{remote}/", "", target)

    execute_command(f"git fetch {remote} {remote_branch}:{target_branch}")

    _, _, return_code = execute_command(
        f"~/loadrc/gitrc/gdi.sh {target_branch} {current_branch} gdit > {output} 2>&1"
    )

    if return_code != 0:
        print("most probably sth wrong in git merge...", file=sys.stderr)
        sys.exit(1)

    remote = get_git_config("gdi2.remote")
    execute_command(f"git push {remote} {target_branch}")


if __name__ == "__main__":
    output_file = sys.argv[1]
    git_sync(output_file)
