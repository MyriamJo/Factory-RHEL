#!/bin/bash
# Locks down the 10 placeholder task files inside each employee's task
# directory: owned by supervisor, group-owned by whichever group should be
# able to read them, mode 750. Run as root, after 02_create_directories.sh
# (does not depend on the completed_tasks drop-box setup).

set -e

BASE=/home/factory/tasks

chown supervisor:group1 "$BASE/operators_task/operator1"/task{1..10}.txt
chown supervisor:group2 "$BASE/operators_task/operator2"/task{1..10}.txt
chown supervisor:group3 "$BASE/operators_task/operator3"/task{1..10}.txt
chmod 750 "$BASE/operators_task/operator1"/task{1..10}.txt
chmod 750 "$BASE/operators_task/operator2"/task{1..10}.txt
chmod 750 "$BASE/operators_task/operator3"/task{1..10}.txt

chown supervisor:Engineer1 "$BASE/engineers_task/engineer1"/task{1..10}.txt
chown supervisor:Engineer2 "$BASE/engineers_task/engineer2"/task{1..10}.txt
chown supervisor:Engineer3 "$BASE/engineers_task/engineer3"/task{1..10}.txt
chmod 750 "$BASE/engineers_task/engineer1"/task{1..10}.txt
chmod 750 "$BASE/engineers_task/engineer2"/task{1..10}.txt
chmod 750 "$BASE/engineers_task/engineer3"/task{1..10}.txt
