#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

python3 ./pythonrc/rsync_folder_operations.test.py
python3 ./pythonrc/rsync_iconv_options.test.py
python3 ./pythonrc/rsync_mkpath_decider.test.py
python3 ./pythonrc/rsync_path_resolver.test.py

cd -
