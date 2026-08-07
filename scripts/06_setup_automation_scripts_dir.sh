#!/bin/bash
# Installs completed_tasks.sh and kpi.sh (the two automation scripts in this
# repo) onto the VM at /home/factory/scripts, sets their ownership/permissions,
# and adds that directory to PATH so they can be run by name. Run as root,
# after the scripts above; run from the root of this repo so the relative
# paths to the two .sh files resolve.

set -e

DEST=/home/factory/scripts
mkdir -p "$DEST"
chown supervisor:factory "$DEST"
chmod 750 "$DEST"

cp "$(dirname "$0")/completed_tasks.sh" "$DEST/completed_tasks.sh"
cp "$(dirname "$0")/kpi.sh" "$DEST/kpi.sh"

chown supervisor:factory "$DEST/completed_tasks.sh"
chmod 750 "$DEST/completed_tasks.sh"

chown supervisor:supervisor "$DEST/kpi.sh"
chmod 770 "$DEST/kpi.sh"

# Persist PATH for future root shells; also export it for the current one.
export PATH="$PATH:$DEST"
if ! grep -qs "$DEST" /root/.bashrc 2>/dev/null; then
    echo "export PATH=\$PATH:$DEST" >> /root/.bashrc
fi
