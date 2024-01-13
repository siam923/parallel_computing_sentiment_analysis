#!/usr/bin/bash
# file name: data.sh

# Activate Python virtual environment
source /home/ubuntu/sentiment/venv/bin/activate
echo "Env activated"
#echo $1

# Run Python script with provided argument
/home/ubuntu/sentiment/venv/bin/python /home/ubuntu/sentiment/data.py "$1"
echo "Execution complete"

# Deactivate Python virtual environment
deactivate
