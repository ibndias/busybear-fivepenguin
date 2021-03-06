#!/bin/bash

. conf/busybear.config

while [[ $# -gt 0 ]] && [[ ."$1" = .--* ]] ;
do
  opt="$1"
  shift
  case "${opt}" in
    "--" )
      break 2
      ;;
    "--no-exec" )
      NOEXEC=true
      ;;
    *)
      echo >&2 "$0: unknown option: ${opt}";
      exit 1
      ;;
  esac
done

#QEMU_NETDEV="type=tap,script=./scripts/ifup.sh,downscript=./scripts/ifdown.sh"

# locate QEMU
#QEMU_SYSTEM_BIN=$(which qemu-system-${ARCH})
QEMU_SYSTEM_BIN="../riscv-mte/install/bin/qemu-system-riscv64"
#QEMU_SYSTEM_BIN="qemu-system-riscv64"
if [ -z ${QEMU_SYSTEM_BIN} ]; then
  echo "Cannot locate qemu-system-${ARCH}"
  exit 1
fi

filename="${1##*/}"
#filename+=""
echo $filename
set -x
#-m 1G,maxmem=3G \
#memmap=512M$2G
# construct command
cmd="${QEMU_SYSTEM_BIN} -nographic -machine virt \
  -kernel build/riscv-pk/bbl -s -S \
	-append \"root=/dev/vda ro console=ttyS0 nokaslr init=/bin/beebs/aha-compress.elf memmap=1G@2G debug_boot_weak_hash \" \
	-drive file=busybear.bin,format=raw,id=hd0 \
  -m 3G \
	-device virtio-blk-device,drive=hd0 \
  -device virtio-net-device,netdev=usernet \
  -netdev user,id=usernet,hostfwd=tcp::10000-:22" 
#  -s -S" 
# use qemu network emulation instead of bridging
#	-netdev ${QEMU_NETDEV},id=net0 \
#	-device virtio-net-device,netdev=net0"

# print or execute command
if [ "${NOEXEC}" = "true" ] ; then
  echo ${cmd} $*
else
  eval "exec sudo ${cmd} $*"
fi
