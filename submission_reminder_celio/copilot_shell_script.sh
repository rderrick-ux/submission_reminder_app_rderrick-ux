#!/bin/bash

script_dir="$(cd "$(dirname "$0")" && pwd)"
config_file="$script_dir/config/config.env"
startup_script="$script_dir/startup.sh"

if [ ! -f "$config_file" ]; then
    echo "Error: config.env not found at $config_file"
    exit 1
fi

if [ ! -f "$startup_script" ]; then
    echo "Error: startup.sh not found at $startup_script"
    exit 1
fi

read -p "Enter the new assignment name: " new_assignment
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$config_file"

echo "Assignment updated to '$new_assignment'. Running reminder app..."
bash "$startup_script"
