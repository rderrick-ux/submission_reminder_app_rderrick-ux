#!/bin/bash

read -p "Enter new assignment name: " new_assignment
app_dir=$(find . -maxdepth 1 -type d -name "submission_reminder_*" | head -n 1)
config_file="$app_dir/config/config.env"

if [ ! -f "$config_file" ]; then
  echo "Error: config.env not found at $config_file"
  exit 1
fi

sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=${new_assignment}/" "$config_file"
echo "Assignment updated to: $new_assignment"
bash "$app_dir/startup.sh"

