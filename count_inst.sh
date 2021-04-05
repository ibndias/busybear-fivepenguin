#!/bin/bash
filename="${1##*/}"

xterm -e ./scripts/start-qemu.sh $1 &

#rm gdb.txt
#rm result.txt
#run gdb
export PATH="$HOME/Documents/Project/riscv-mte/install/bin:$PATH"
riscv64-unknown-linux-gnu-gdb $1 -x script.gdb -batch-silent
#parse log
cat gdb.txt \
| grep "=>" \
| awk '{ for (i=1; i<=NF; ++i) { if ($i ~ ":$") print $(i+1) } }' \
| tr ' ' '\12' | sort | uniq -c | sort -nr > summary-$filename.txt

mv gdb.txt log-$filename.txt