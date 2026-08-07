# Factory User & Task Management — RHEL System Administration

A small factory's employee/task-tracking system built entirely out of Linux users, groups, and
filesystem permissions on Red Hat Enterprise Linux — no application code, just the OS's own
access-control primitives doing the enforcement, plus two bash scripts for the day-to-day
workflow.

## Scenario

One supervisor oversees 3 engineers and 3 operators, organized into 3 paired production lines
(each pairing one engineer with one operator). Every employee is assigned 10 tasks. Employees
submit finished tasks into a personal drop box; the supervisor runs a script that scores each
employee's completion ratio. Everything — who can read whose task list, who can submit where, who
can see what's been turned in — is enforced by Unix ownership, group membership, and permission
bits, rather than by any application logic.

```
scripts/
├── 00_create_users.sh                    # create supervisor + 6 employee accounts
├── 01_create_groups.sh                   # create factory/engineers/operators/group1-3 + membership
├── 02_create_directories.sh              # build the /home/factory tree, seed task files
├── 03_set_ownership_and_permissions.sh   # lock down the directory tree
├── 04_setup_completed_tasks_dropboxes.sh # per-employee submission boxes (setgid + sticky bit)
├── 05_set_task_file_permissions.sh       # lock down the individual task files
├── 06_setup_automation_scripts_dir.sh    # install the two scripts below onto the VM, set PATH
├── completed_tasks.sh                    # (run by employees) submit a finished task
├── kpi.sh                                # (run by supervisor) score completion ratios
└── run_all.sh                            # runs everything above in order

docs/
├── permissions-reference.md   # full ownership/permission tables
└── directory-structure.md     # directory tree with a description of each part
```

## Permission design

Two ideas do most of the work here:

**Group-scoped read access.** Each employee's task directory and task files are group-owned by a
group only they (and, for the paired production-line groups, their line partner) belong to, with
mode 750 — so the supervisor (who owns everything) can always read and write, the assigned
employee can read, and nobody else on the system can see it at all.

**The drop-box pattern for submissions.** Each employee's `completed_tasks/<name>` directory
combines two special permission bits: setgid, so any file they drop in is automatically
group-owned by `supervisor` regardless of the submitter's own group; and the sticky bit, so once a
file is submitted, only its owner or the supervisor can delete or rename it — a submission can't
be tampered with after the fact, even by someone who could otherwise write to that directory.
`docs/permissions-reference.md` has the full ownership/permission tables and explains the exact
bits.