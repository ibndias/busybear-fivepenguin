#!/bin/bash
rm gdb.txt
rm result.txt
#run gdb
export PATH="$HOME/Documents/Project/riscv-mte/install/bin:$PATH"
riscv64-unknown-linux-gnu-gdb -x script_dbg.gdb
#parse log
