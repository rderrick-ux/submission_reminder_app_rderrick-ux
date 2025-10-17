#!/bin/bash

script_dir="$(cd "$(dirname "$0")" && pwd)"
base_dir="$(dirname "$script_dir")"
source "$base_dir/config/config.env"
source "$base_dir/modules/functions.sh"

submissions_file="$base_dir/assets/submissions.txt"

echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "$submissions_file"
