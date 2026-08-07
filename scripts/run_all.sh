#!/bin/bash
# Runs every provisioning script in order to build the full environment from
# scratch. Run as root, from a fresh RHEL/CentOS VM, from the root of this repo.
#
#   ./scripts/run_all.sh
#
# 00_create_users.sh will prompt you interactively for each account's
# password - there's no way around that step running non-interactively
# without hardcoding passwords into a script, which isn't something to do
# even for a lab environment.

set -e
DIR="$(cd "$(dirname "$0")" && pwd)"

"$DIR/00_create_users.sh"
"$DIR/01_create_groups.sh"
"$DIR/02_create_directories.sh"
"$DIR/03_set_ownership_and_permissions.sh"
"$DIR/04_setup_completed_tasks_dropboxes.sh"
"$DIR/05_set_task_file_permissions.sh"
"$DIR/06_setup_automation_scripts_dir.sh"

echo "Done. /home/factory is set up; completed_tasks.sh and kpi.sh are installed at /home/factory/scripts."
