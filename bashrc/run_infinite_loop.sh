#!/bin/zsh

# Check if a target file name is provided
if [ -z "$1" ]
then
    echo "Please provide the target file name..."
    exit 1
fi

targetFile="$1"

# Function to run the script in an infinite loop
run_in_loop() {
    while true; do
        ./run_once_script_checker.sh "$targetFile" "$2" "$3" "$4"
        sleep 1  # Optional: sleep for 1 second before the next iteration
    done
}

# Run the target script in an infinite loop
run_in_loop
