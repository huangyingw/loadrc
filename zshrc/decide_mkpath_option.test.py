import unittest
import subprocess

SCRIPT_PATH = "./decide_mkpath_option.zsh"


class TestDecideMkpathOption(unittest.TestCase):
    def test_local_mkpath_option(self):
        # Test if the --mkpath option is used with local folders
        source_folder = "./source_folder"
        target_folder = "./target_folder"
        output = subprocess.run(
            f"{SCRIPT_PATH} {source_folder} {target_folder}",
            capture_output=True,
            text=True,
            shell=True,
        )

        local_rsync_version = subprocess.run(
            "rsync --version | head -n 1 | awk '{print $3}'",
            capture_output=True,
            text=True,
            shell=True,
        ).stdout.strip()

        if float(local_rsync_version) >= 3.2:
            self.assertEqual(output.stdout.strip(), "--mkpath")
        else:
            self.assertEqual(output.stdout.strip(), "")

    def test_remote_mkpath_option(self):
        # Test if the --mkpath option is used with remote folders
        # Replace 'user@example.com' with a valid remote user and host
        source_folder = "user@example.com:/path/to/source_folder"
        target_folder = "user@example.com:/path/to/target_folder"
        output = subprocess.run(
            f"{SCRIPT_PATH} {source_folder} {target_folder}",
            capture_output=True,
            text=True,
            shell=True,
        )

        remote_rsync_version = subprocess.run(
            f"ssh {source_folder.split(':')[0]} 'rsync --version' | head -n 1 | awk '{{print $3}}'",
            capture_output=True,
            text=True,
            shell=True,
        ).stdout.strip()

        if float(remote_rsync_version) >= 3.2:
            self.assertEqual(output.stdout.strip(), "--mkpath")
        else:
            self.assertEqual(output.stdout.strip(), "")


if __name__ == "__main__":
    unittest.main()
