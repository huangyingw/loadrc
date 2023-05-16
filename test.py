import os
import subprocess
import sys
import glob

# Get the absolute path of the current script
script_path = os.path.realpath(__file__)
dir_path = os.path.dirname(script_path)

# Navigate to the script directory
os.chdir(dir_path)

# Find all python test scripts in the 'pythonrc' directory
test_scripts = glob.glob("./pythonrc/*.test.py")

# Execute each test
for script in test_scripts:
    print(f"Starting test: {script}")
    result = subprocess.run(["python3", script])

    # If the test script fails (non-zero exit status), abort immediately
    if result.returncode != 0:
        print(f"Test {script} failed. Aborting.")
        sys.exit(1)
    else:
        print(f"Finished test: {script}")

# If all test scripts pass (the script has not yet exited), print a success message
print("All test scripts passed successfully.")
