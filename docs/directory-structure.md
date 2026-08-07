# Directory structure

```
/home/factory/
├── tasks/
│   ├── operators_task/
│   │   ├── operator1/   task1.txt … task10.txt
│   │   ├── operator2/   task1.txt … task10.txt
│   │   └── operator3/   task1.txt … task10.txt
│   └── engineers_task/
│       ├── engineer1/   task1.txt … task10.txt
│       ├── engineer2/   task1.txt … task10.txt
│       └── engineer3/   task1.txt … task10.txt
├── employee_performance/
│   ├── completed_tasks/
│   │   ├── operator1/   (Operator1 drops finished task files here)
│   │   ├── operator2/
│   │   ├── operator3/
│   │   ├── engineer1/   (Engineer1 drops finished task files here)
│   │   ├── engineer2/
│   │   └── engineer3/
│   ├── operator1.txt … operator3.txt   (completion ratio history, written by kpi.sh)
│   └── engineer1.txt … engineer3.txt
└── scripts/
    ├── completed_tasks.sh   (employees run this to submit a finished task)
    └── kpi.sh                (supervisor runs this to score completion ratios)
```

`tasks/` holds each employee's assigned work (read-only to them); `completed_tasks/` holds what
they've turned in (read-write to them, read-only to everyone but the owner and supervisor once a
file lands, thanks to the sticky bit). `kpi.sh` compares the two counts per employee to produce a
completion ratio.
