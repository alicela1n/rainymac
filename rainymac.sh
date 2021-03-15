#!/usr/bin/env bash
# Do not touch this if you don't know what you're doing !!
source ./rainymac.cfg

args=()
args+=("-L pc-bios")
args+=("-m $ram" )
args+=("-boot $bootdevice ")
args+=("-prom-env \"boot-args=$bootargs\" ")
args+=("-M $machine ")
args+=("-hda $hdd ")
args+=("-boot $bootdevice ")
# Probably not so efficient but whatever it works
if [ $cdrom == on ]
then
    args+=("-cdrom $iso")
fi

if [ $usbaudio == on ] 
then
    args+=("-device ich9-usb-uhci1,id=newusb -device usb-audio,bus=newusb.0")
fi

if [ $autoboot == off ] 
then
    args+=("-prom-env \"auto-boot?=false\"")
fi

if [ $networking == on ] && [ $ssh_forward == on ]
then
    args+=("-netdev user,id=mynet0,hostfwd=tcp::5555-:22 -device sungem,netdev=mynet0")
elif [ $networking == on ]
then
    args+=("-netdev user,id=mynet0 -device sungem,netdev=mynet0")
elif [ $networking == off ]
then
    args+=("-nic none")
fi

if [ $accelerate_with_tcg == on ]
then
    args+=("-accel tcg")
fi

if [ $ssh_forward == on ]
then
    printf "SSH is running on port 5555\n"
    printf "Connect using ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -c 3des-cbc localhost -p 5555\n"
fi

if [ $vnc == on ]
then
    printf "Starting with VNC on port 5900\n"
    args+=("-vnc :0")
fi

qemu_args="${args[*]}"
$qemu $qemu_args
