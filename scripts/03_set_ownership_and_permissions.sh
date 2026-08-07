#!/bin/bash
# Sets ownership and permissions on the top-level factory directories. Run as
# root, after 02_create_directories.sh. Every directory here ends up owned by
# supervisor, group-owned by the team that should have read/execute access,
# and mode 750 (rwx for the owner, r-x for the group, nothing for everyone
# else) - see docs/permissions-reference.md for the full table and a note on
# one discrepancy in the original report this was reconstructed from.

set -e

BASE=/home/factory

chown supervisor:factory "$BASE"
chmod 750 "$BASE"

chown supervisor:factory "$BASE/tasks"
chown supervisor:factory "$BASE/employee_performance"
chmod 750 "$BASE/tasks"
chmod 750 "$BASE/employee_performance"

chown supervisor:factory "$BASE/tasks/operators_task"
chown supervisor:engineers "$BASE/tasks/engineers_task"
chmod 750 "$BASE/tasks/operators_task"
chmod 750 "$BASE/tasks/engineers_task"

chown supervisor:group1 "$BASE/tasks/operators_task/operator1"
chown supervisor:group2 "$BASE/tasks/operators_task/operator2"
chown supervisor:group3 "$BASE/tasks/operators_task/operator3"
chmod 750 "$BASE/tasks/operators_task"/{operator1,operator2,operator3}

chown supervisor:Engineer1 "$BASE/tasks/engineers_task/engineer1"
chown supervisor:Engineer2 "$BASE/tasks/engineers_task/engineer2"
chown supervisor:Engineer3 "$BASE/tasks/engineers_task/engineer3"
chmod 750 "$BASE/tasks/engineers_task"/{engineer1,engineer2,engineer3}
