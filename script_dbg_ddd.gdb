# to debug kernel, generate kernel.sym with objcopy --only-keep-debug vmlinux kernel.sym
# file ./kernel.sym
# hbreak start_kernel

target remote :1234

# User program compiled with 
# riscv64-unknown-linux-gnu-gcc -g -O0 hello.c -o hello -static
#or
# clang -g -O0 -static hello.c -o hello -march=rv64g

#file ./hello
#b derry
#file ../riscv-benchmark/results/qurt.elf
b start_trigger
b main
c
#set height 0
#set style enabled off
#while (1) 
#    x/i $pc
#    stepi
#end
#quit