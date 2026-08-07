#!/bin/bash
# Submits a completed task file to the current user's drop box.
#
# Usage: completed_tasks.sh /path/to/task_file.txt
#
# Copies the given file into
#   /home/factory/employee_performance/completed_tasks/<lowercase-username>
# The destination directory name is derived from whoami, lowercased, so
# Engineer1 running this submits into .../completed_tasks/engineer1. Every
# employee has read/write access to only their own drop box (see
# 04_setup_completed_tasks_dropboxes.sh), so this script needs no extra
# permission logic of its own - the filesystem already enforces who can
# submit where.

username=$(whoami)
lower=${username,,}

cp "$1" "/home/factory/employee_performance/completed_tasks/$lower"
