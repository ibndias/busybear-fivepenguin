# to debug kernel, generate kernel.sym with objcopy --only-keep-debug vmlinux kernel.sym
# file ./kernel.sym
# hbreak start_kernel

target remote :1234
set confirm off

# User program compiled with 
# riscv64-unknown-linux-gnu-gcc -g -O0 hello.c -o hello -static
file ./hello
b main
c
set logging overwrite on
set logging on
set height 0
set style enabled off
while (1) 
    x/i $pc
    stepi
end
quit