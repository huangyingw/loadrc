#!/bin/zsh

# Get the PIDs of the top 10 I/O-consuming processes
PIDS=$(iotop -b -n 1 -o -k | awk 'NR>2 {print $1, $10}' | sort -k2 -nr | head -n 10 | awk '{print $1}')

for PID in ${(z)PIDS}; do
    # Validate that this is a number
    if [[ "$PID" =~ ^[0-9]+$ ]]; then
        echo "Killing PID $PID"
        kill $PID
        sleep 1 # Pause for a moment in case you need to stop the script
    fi
done
