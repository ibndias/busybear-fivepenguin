#!/bin/bash
./scripts/start-qemu.sh
riscv64-unknown-linux-gnu-gdb -x script.gdb 