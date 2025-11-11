#!/bin/bash
echo "Creating test environment..."
python3 -m venv temp_test_env
source temp_test_env/bin/activate

echo "Installing requirements..."
pip3 install -r requirements.txt

echo "Checking for conflicts..."
pip3 check

echo "Checking for outdated packages..."
pip3 list --outdated

echo "Cleaning up..."
deactivate
rm -rf temp_test_env