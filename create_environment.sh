#!/bin/bash

read -p "Enter your name: " username
base_dir="$(pwd)/submission_reminder_${username}"

mkdir -p "$base_dir"/config "$base_dir"/modules "$base_dir"/assets "$base_dir"/app

cat <<EOF > "$base_dir/config/config.env"
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

cat <<'EOF' > "$base_dir/modules/functions.sh"
#!/bin/bash

function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"
    while IFS=, read -r student assignment status; do
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file")
}
EOF

cat <<EOF > "$base_dir/assets/submissions.txt"
student, assignment, submission status
Celio Derrick, Shell Navigation, not submitted
Steph Curry, Git, submitted
Kevin Durant, Shell Navigation, not submitted
LeBron James, Shell Basics, submitted
Kai Cenat, Shell Navigation, submitted
Cristiano Ronaldo, Shell Navigation, not submitted
Lionel Messi, Git, not submitted
Imena Kizito, Shell Navigation, not submitted
Flight Reacts, Shell Basics, submitted
EOF

cat <<'EOF' > "$base_dir/app/reminder.sh"
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
EOF

cat <<'EOF' > "$base_dir/startup.sh"
#!/bin/bash
  
echo "Starting Submission Reminder App..."
script_dir="$(cd "$(dirname "$0")" && pwd)"
bash "$script_dir/app/reminder.sh"

EOF

find "$base_dir" -type f -name "*.sh" -exec chmod +x {} \;

echo "Environment setup complete in $base_dir"

