#!/bin/bash
# Creates the supervisor account plus 3 engineer and 3 operator accounts for the
# factory. Run as root. You will be prompted to set a password for each account
# interactively (passwd is intentionally left interactive rather than scripted,
# since piping plaintext passwords into a script is not something to normalize).
#
# On RHEL, `useradd` also creates a private group matching each username by
# default (e.g. user Engineer1 gets group Engineer1) - later scripts rely on
# that private group to grant each engineer/operator exclusive access to their
# own submitted-work directory.

set -e

USERS=(supervisor Engineer1 Engineer2 Engineer3 Operator1 Operator2 Operator3)

for user in "${USERS[@]}"; do
    if id -u "$user" >/dev/null 2>&1; then
        echo "User $user already exists, skipping useradd."
    else
        useradd "$user"
    fi
    echo "Set a password for $user:"
    passwd "$user"
done
