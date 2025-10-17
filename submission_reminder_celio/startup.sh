#!/bin/bash
  
echo "Starting Submission Reminder App..."
script_dir="$(cd "$(dirname "$0")" && pwd)"
bash "$script_dir/app/reminder.sh"

