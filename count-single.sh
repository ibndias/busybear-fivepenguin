#!/bin/bash
filename="${1##*/}"

set -x
xterm -e ./scripts/start-qemu.sh $1 &

test -d result || mkdir result
test -d result/log || mkdir result/log
test -d result/hist || mkdir result/hist
#rm gdb.txt
#rm result.txt
#run gdb
export PATH="$HOME/Documents/Project/riscv-mte/install/bin:$PATH"
#riscv64-unknown-linux-gnu-gdb $1 -x script.gdb -batch-silent
riscv64-unknown-linux-gnu-gdb $1 -x script.gdb -batch \
| grep "=>" \
| awk '{ for (i=1; i<=NF; ++i) { if ($i ~ ":$") print $(i+1) } }' \
| tr ' ' '\12' | sort | uniq -c | awk ' {print $2 " " $1} ' > result/hist/$filename-hist.txt
#| tr ' ' '\12' | sort | uniq -c | sort -nr > result/hist/$filename-hist.txt

mv gdb.txt result/log/$filename-log.txt