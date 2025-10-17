#!/bin/bash

source "/submission_reminder_app_rderrick-ux/submission_reminder_celio/config/config.env"
source "/submission_reminder_app_rderrick-ux/submission_reminder_celio/modules/functions.sh"

submissions_file="/submission_reminder_app_rderrick-ux/submission_reminder_celio/assets/submissions.txt"

echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "$submissions_file"
