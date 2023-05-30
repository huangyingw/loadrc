#!/usr/bin/env python3

# gdit.test.py

import unittest
from unittest.mock import patch, Mock
import gdit


class TestGdit(unittest.TestCase):
    @patch("gdit.execute_command")
    @patch("gdit.get_git_config")
    def test_git_sync(self, mock_get_git_config, mock_execute_command):
        # Mock the execute_command function to return specific values
        mock_execute_command.side_effect = lambda x: {
            "~/loadrc/gitrc/get_current_branch.sh": ("main.fix", "", 0),
            "~/loadrc/gitrc/gdi.sh main main gdit > output.txt 2>&1": (
                "",
                "",
                0,
            ),
            "git branch main main": ("", "", 0),
            "git fetch origin main:main": ("", "", 0),
            "git fetch origin main:main": ("", "", 0),
            "git push origin main": ("", "", 0),
        }.get(x, ("", "", 0))

        # Mock the get_git_config function to return specific values for certain keys
        mock_get_git_config.side_effect = lambda x: {
            "gsync.remote": "origin",
            "gsync.target": "main",
            "fetch.from": "origin/main",
            "gdi2.remote": "origin",
        }.get(x, None)

        gdit.git_sync("output.txt")

        # Check if execute_command and get_git_config were called with the correct arguments
        mock_execute_command.assert_any_call(
            "~/loadrc/gitrc/get_current_branch.sh"
        )
        mock_execute_command.assert_any_call("git branch main main")
        mock_execute_command.assert_any_call("git fetch origin main:main")
        mock_execute_command.assert_any_call("git fetch origin main:main")
        mock_execute_command.assert_any_call(
            "~/loadrc/gitrc/gdi.sh main main gdit > output.txt 2>&1"
        )
        mock_execute_command.assert_any_call("git push origin main")

        mock_get_git_config.assert_any_call("gsync.remote")
        mock_get_git_config.assert_any_call("gsync.target")
        mock_get_git_config.assert_any_call("fetch.from")
        mock_get_git_config.assert_any_call("gdi2.remote")


if __name__ == "__main__":
    unittest.main()
