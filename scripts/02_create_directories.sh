#!/bin/bash
# Builds the factory's directory tree under /home/factory and seeds each
# employee's task directory with 10 placeholder task files. Run as root,
# after 01_create_groups.sh.
#
# Layout created:
#   /home/factory/
#   ├── tasks/
#   │   ├── operators_task/{operator1,operator2,operator3}/task{1..10}.txt
#   │   └── engineers_task/{engineer1,engineer2,engineer3}/task{1..10}.txt
#   └── employee_performance/
#       └── completed_tasks/        (populated by 04_setup_completed_tasks_dropboxes.sh)
#
# Note: directory and file names here are lowercase (operator1, engineer1, ...)
# even though the Linux usernames are capitalized (Operator1, Engineer1, ...) -
# that split is intentional and is what completed_tasks.sh relies on when it
# lowercases $(whoami) to find the matching drop-box directory.

set -e

BASE=/home/factory

mkdir -p "$BASE/tasks/operators_task"/{operator1,operator2,operator3}
mkdir -p "$BASE/tasks/engineers_task"/{engineer1,engineer2,engineer3}
mkdir -p "$BASE/employee_performance"

for operator in operator1 operator2 operator3; do
    touch "$BASE/tasks/operators_task/$operator"/task{1..10}.txt
done

for engineer in engineer1 engineer2 engineer3; do
    touch "$BASE/tasks/engineers_task/$engineer"/task{1..10}.txt
done
