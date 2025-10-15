#!/bin/bash

read -p "Enter your name: " username
base_dir="$(pwd)/submission_reminder_${username}"

mkdir -p "$base_dir"/config "$base_dir"/modules "$base_dir"/assets
touch "$base_dir/image.png"

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

cat <<EOF > "$base_dir/reminder.sh"
#!/bin/bash

source "$base_dir/config/config.env"
source "$base_dir/modules/functions.sh"

submissions_file="$base_dir/assets/submissions.txt"

echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "\$submissions_file"
EOF

cat <<EOF > "$base_dir/startup.sh"
#!/bin/bash

echo "Starting Submission Reminder App..."
bash "$base_dir/reminder.sh"
EOF

find "$base_dir" -type f -name "*.sh" -exec chmod +x {} \;

echo "Environment setup complete in $base_dir"
cat <<EOF > "$base_dir/copilot_shell_script.sh"
#!/bin/bash

script_dir="\$(cd "\$(dirname "\$0")" && pwd)"
config_file="\$script_dir/config/config.env"
startup_script="\$script_dir/startup.sh"

if [ ! -f "\$config_file" ]; then
    echo "Error: config.env not found at \$config_file"
    exit 1
fi

if [ ! -f "\$startup_script" ]; then
    echo "Error: startup.sh not found at \$startup_script"
    exit 1
fi

read -p "Enter the new assignment name: " new_assignment
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"\$new_assignment\"/" "\$config_file"

echo "Assignment updated to '\$new_assignment'. Running reminder app..."
bash "\$startup_script"
EOF

chmod +x "$base_dir/copilot_shell_script.sh"

