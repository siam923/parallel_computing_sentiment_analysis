#!/usr/bin/bash
echo "Running as user: $(whoami)"
echo "Groups: $(groups)"
echo "Python version: $(python3 --version)"
echo "Contents of sentiment directory:"
ls -l /home/ubuntu/sentiment
echo "Activating Python environment:"
source /home/ubuntu/sentiment/venv/bin/activate
python3 -c "import sys; print('Python path:', sys.path)"
deactivate
