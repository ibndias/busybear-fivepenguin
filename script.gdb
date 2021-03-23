# to debug kernel, generate kernel.sym with objcopy --only-keep-debug vmlinux kernel.sym
# file ./kernel.sym
# hbreak start_kernel

target remote :1234

# User program compiled with 
# riscv64-unknown-linux-gnu-gcc -g -O0 hello.c -o hello -static
file ./hello
b derry
c