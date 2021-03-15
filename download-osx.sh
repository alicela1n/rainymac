#!/usr/bin/env bash
printf "Downloading OS X Tiger\n"
printf "You will need to have aria2 installed\n"
aria2c https://archive.org/download/691-5305-A2ZMac_OS_X_v10.4_Tiger._Includes_Xcode_2._Install_Disc_2005_DVD/691-5305-A%2C2Z%2CMac%20OS%20X%20v10.4%20Tiger.%20Includes%20Xcode%202.%20Install%20Disc_2005%20%28DVD%29.toast -o Tiger.iso
printf "Saved to Tiger.iso!\n"
