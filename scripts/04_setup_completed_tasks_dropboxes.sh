#!/bin/bash
# Creates a personal "drop box" directory under completed_tasks/ for every
# engineer and operator, and applies two special permission bits to each:
#
#   setgid (g+s)  - any file an employee drops in their box inherits the box's
#                   group (supervisor), instead of the creating user's own
#                   group, so the supervisor can always read it.
#   sticky (o+t)  - once a file is dropped in the box, only its owner (or
#                   supervisor/root) can rename or delete it - one employee
#                   can't tamper with another's submission even if directory
#                   permissions were ever loosened.
#
# Combined with mode 770 (owner + group get full access, everyone else gets
# none), this reproduces the "rwx,rws,--T" permission string from the report.
# Run as root, after 03_set_ownership_and_permissions.sh.

set -e

DROPBOX="/home/factory/employee_performance/completed_tasks"
mkdir -p "$DROPBOX"
chown supervisor:factory "$DROPBOX"
chmod 750 "$DROPBOX"

mkdir -p "$DROPBOX"/{engineer1,engineer2,engineer3,operator1,operator2,operator3}

chown Engineer1:supervisor "$DROPBOX/engineer1"
chown Engineer2:supervisor "$DROPBOX/engineer2"
chown Engineer3:supervisor "$DROPBOX/engineer3"
chown Operator1:supervisor "$DROPBOX/operator1"
chown Operator2:supervisor "$DROPBOX/operator2"
chown Operator3:supervisor "$DROPBOX/operator3"

for dir in engineer1 engineer2 engineer3 operator1 operator2 operator3; do
    chmod 770 "$DROPBOX/$dir"
    chmod g+s "$DROPBOX/$dir"
    chmod o+t "$DROPBOX/$dir"
done
