#!/bin/bash
# Creates the factory's shared groups and assigns every user to the groups
# their role requires. Run as root, after 00_create_users.sh.
#
# Groups:
#   factory     - every employee (supervisor + all engineers + all operators)
#   engineers   - all 3 engineers
#   operators   - all 3 operators
#   group1/2/3  - one engineer + one operator paired together per production line
#   supervisors - holds the supervisor account (used for the kpi.sh script's
#                 group ownership later; not called for explicitly in the
#                 original brief, but present in the source implementation)

set -e

GROUPS=(factory engineers operators group1 group2 group3 supervisors)

for group in "${GROUPS[@]}"; do
    if getent group "$group" >/dev/null 2>&1; then
        echo "Group $group already exists, skipping groupadd."
    else
        groupadd "$group"
    fi
done

# Everyone belongs to "factory"
for user in supervisor Engineer1 Engineer2 Engineer3 Operator1 Operator2 Operator3; do
    usermod -aG factory "$user"
done

# Role groups
for user in Engineer1 Engineer2 Engineer3; do
    usermod -aG engineers "$user"
done
for user in Operator1 Operator2 Operator3; do
    usermod -aG operators "$user"
done

# Paired production-line groups
usermod -aG group1 Engineer1
usermod -aG group1 Operator1
usermod -aG group2 Engineer2
usermod -aG group2 Operator2
usermod -aG group3 Engineer3
usermod -aG group3 Operator3

# Supervisor group
usermod -aG supervisors supervisor
