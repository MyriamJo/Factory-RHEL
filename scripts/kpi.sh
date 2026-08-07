#!/bin/bash
# Calculates a completion ratio for every operator and engineer and appends it
# to that employee's performance file.
#
# For each employee, "completed" is the number of files currently sitting in
# their completed_tasks drop box, and "total" is the number of task files
# assigned to them in tasks/{operators_task,engineers_task}/<name>. Both counts
# come from `ls -l | wc -l`, which includes a leading "total N" summary line,
# so 1 is subtracted from the denominator to get the true file count.
#
# Result is written to
#   /home/factory/employee_performance/<name>.txt
# - the file is created on first run and appended to on every run after that,
# so it builds up a history of an employee's completion ratio over time
# rather than only showing the latest snapshot.
#
# Known limitation carried over from the original implementation: bash only
# does integer division, so completed/total truncates to 0 whenever completed
# is less than total (e.g. 3 completed out of 10 assigned reports as 0, not
# 0.3). Piping the division through `bc -l` or awk would give a fractional
# result if that's preferred - left as-is here since that's how it was
# originally implemented and verified.

for i in {1..3}; do
    num="/home/factory/employee_performance/completed_tasks/operator$i"
    denum="/home/factory/tasks/operators_task/operator$i"
    performance="/home/factory/employee_performance/operator$i.txt"

    count_n=$(ls -l "$num" | wc -l)
    count_d=$(ls -l "$denum" | wc -l)
    ((count_d--))
    value=$((count_n / count_d))

    if [ ! -f "$performance" ]; then
        echo "$value" > "$performance"
    else
        echo "$value" >> "$performance"
    fi
done

for j in {1..3}; do
    num="/home/factory/employee_performance/completed_tasks/engineer$j"
    denum="/home/factory/tasks/engineers_task/engineer$j"
    performance="/home/factory/employee_performance/engineer$j.txt"

    count_n=$(ls -l "$num" | wc -l)
    count_d=$(ls -l "$denum" | wc -l)
    ((count_d--))
    value=$((count_n / count_d))

    if [ ! -f "$performance" ]; then
        echo "$value" > "$performance"
    else
        echo "$value" >> "$performance"
    fi
done
