# Permissions reference

## Directory ownership (set by `03_set_ownership_and_permissions.sh`)

| Path | Owning user | Owning group | Mode |
|---|---|---|---|
| `/home/factory` | supervisor | factory | 750 (`rwx,r-x,---`) |
| `/home/factory/tasks` | supervisor | factory | 750 |
| `/home/factory/employee_performance` | supervisor | factory | 750 |
| `/home/factory/tasks/operators_task` | supervisor | factory | 750 |
| `/home/factory/tasks/engineers_task` | supervisor | engineers | 750 |
| `/home/factory/tasks/operators_task/operator1` | supervisor | group1 | 750 |
| `/home/factory/tasks/operators_task/operator2` | supervisor | group2 | 750 |
| `/home/factory/tasks/operators_task/operator3` | supervisor | group3 | 750 |
| `/home/factory/tasks/engineers_task/engineer1` | supervisor | Engineer1 | 750 |
| `/home/factory/tasks/engineers_task/engineer2` | supervisor | Engineer2 | 750 |
| `/home/factory/tasks/engineers_task/engineer3` | supervisor | Engineer3 | 750 |

**Note on a discrepancy in the source report:** the original report's own summary table listed
`operators_task` as group-owned by `engineers`, but the terminal transcript in the same report
actually runs `chown supervisor:factory operators_task/` and `chown supervisor:engineers
engineers_task/` — i.e. it's `engineers_task` that's group-owned by `engineers`, not
`operators_task`. The table above (and `03_set_ownership_and_permissions.sh`) follows the
terminal transcript, since that's what was actually executed. Worth double-checking against your
own VM if you still have it running, in case the table was right and the transcript's screenshots
were shown out of order.

`Engineer1`, `Engineer2`, and `Engineer3` above are not explicitly-created groups — RHEL's
`useradd` creates a private group matching every new username by default, so each engineer
already has their own personal group to be used for exactly this kind of single-owner access.

## Task file ownership (set by `05_set_task_file_permissions.sh`)

Every `task1.txt`–`task10.txt` file inside an employee's task directory is owned by `supervisor`,
group-owned by that employee's group (same grouping as their parent directory above), mode 750.

## Drop-box permissions (set by `04_setup_completed_tasks_dropboxes.sh`)

| Path | Owning user | Owning group | Mode |
|---|---|---|---|
| `completed_tasks/operator1` | Operator1 | supervisor | `rwx,rws,--T` |
| `completed_tasks/operator2` | Operator2 | supervisor | `rwx,rws,--T` |
| `completed_tasks/operator3` | Operator3 | supervisor | `rwx,rws,--T` |
| `completed_tasks/engineer1` | Engineer1 | supervisor | `rwx,rws,--T` |
| `completed_tasks/engineer2` | Engineer2 | supervisor | `rwx,rws,--T` |
| `completed_tasks/engineer3` | Engineer3 | supervisor | `rwx,rws,--T` |

`rwx,rws,--T` is mode 770 plus setgid (the `s`) plus the sticky bit (the `T`, capitalized because
"other" has no execute permission to combine it with). See the comment header in
`04_setup_completed_tasks_dropboxes.sh` for what each bit is doing here and why.

## Automation scripts directory (set by `06_setup_automation_scripts_dir.sh`)

| Path | Owning user | Owning group | Mode |
|---|---|---|---|
| `/home/factory/scripts` | supervisor | factory | 750 |
| `/home/factory/scripts/completed_tasks.sh` | supervisor | factory | 750 |
| `/home/factory/scripts/kpi.sh` | supervisor | supervisor | 770 |
