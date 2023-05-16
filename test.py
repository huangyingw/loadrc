import os
import subprocess
import sys

# Get the absolute path of the current script
script_path = os.path.realpath(__file__)
dir_path = os.path.dirname(script_path)

# Navigate to the script directory
os.chdir(dir_path)

# List of python test scripts
test_scripts = [
    "./pythonrc/folder_content_migrator.test.py",
    "./pythonrc/rsync_folder_operations.test.py",
    "./pythonrc/rsync_iconv_options.test.py",
    "./pythonrc/rsync_mkpath_decider.test.py",
    "./pythonrc/rsync_path_resolver.test.py",
]

# Execute each test
for script in test_scripts:
    result = subprocess.run(["python3", script])

    # If the test script fails (non-zero exit status), abort immediately
    if result.returncode != 0:
        print(f"Test {script} failed. Aborting.")
        sys.exit(1)
