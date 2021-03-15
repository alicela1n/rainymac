# Do not edit if you don't know what you're doing
#!/usr/bin/env bash

if [ ! -f rainymac.qcow2 ]
then
    read -p 'Enter virtual drive capacity in GB (ex: 8): ' capacity

    # Creating qcow2 image
    printf "Creating rainymac.qcow2...\n"
    qemu-img create -f qcow2 rainymac.qcow2 $capacity\G
fi

# Enter path to iso file
read -p "Enter path to iso file (ex: Tiger.iso): " install_iso

source ./rainymac.cfg
# Starting QEMU
printf "Starting QEMU with minimal options for install\n"
printf "If installer requires a disk 2, close QEMU and rerun the script with --stage2 and put in disk2\n"
args=()
args+=("-L pc-bios")
args+=("-m $ram" )
args+=("-prom-env \"boot-args=\"-v\"\" ")
args+=("-M $machine ")
args+=("-hda rainymac.qcow2 ")
args+=("-cdrom $install_iso")
args+=("-nic none")
key="$1"
case $key in
    --stage2) args+=("-boot c") ;;
    *) args+=("-boot d") ;;
esac

qemu_args="${args[*]}"
$qemu $qemu_args
