import os
import subprocess
import tempfile


def test_rsync_folder_operations(mode, expected_options):
    source_folder = tempfile.mkdtemp()
    target_folder = tempfile.mkdtemp()

    with open(os.path.join(source_folder, "test_file.txt"), "w") as f:
        f.write("test_file")

    command = f"~/loadrc/zshrc/rsync_folder_operations.zsh {source_folder} {target_folder} {mode}"
    output = subprocess.check_output(
        command, shell=True, text=True, stderr=subprocess.STDOUT
    )

    if expected_options in output:
        print(f"[{mode}] Test Passed")
    else:
        print(f"[{mode}] Test Failed")
        print(f"Expected: {expected_options}")
        print(f"Actual: {output}")

    # Cleanup
    subprocess.run(f"rm -rf {source_folder}", shell=True)
    subprocess.run(f"rm -rf {target_folder}", shell=True)


if __name__ == "__main__":
    test_rsync_folder_operations("move", "--remove-source-files")
    test_rsync_folder_operations("copy", "")
    test_rsync_folder_operations("mirror", "--delete-before")
    test_rsync_folder_operations("tmirror", "-in --delete-before")
