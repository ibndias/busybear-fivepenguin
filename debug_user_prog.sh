#!/bin/bash
rm gdb.txt
rm result.txt
#run gdb
riscv64-unknown-linux-gnu-gdb -x script.gdb -batch-silent
#parse log
cat gdb.txt \
| grep "=>" \
| awk '{ for (i=1; i<=NF; ++i) { if ($i ~ ":$") print $(i+1) } }' \
| tr ' ' '\12' | sort | uniq -c | sort -nr > result.txt