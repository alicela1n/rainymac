# rainymac
Easy setup PPC versions of Mac OS X in QEMU!
![screenshot](/screenshots/screenshot.png)

# Requirements
* A decent processor, otherwise performance is terrible
* \> 1GB RAM unless you adjust the configuration
* \> 10GB of drive space, 32 or up recommended
* ISO of the version of OS X you want, you can download Tiger with `./download-osx.sh`
* qemu-system-ppc installed
* aria2 (for downloading iso)

# Installation
If you don't already have an iso you can download Tiger by running `./download-osx.sh`.
* For easy installation run `./install.sh` and give it the path to your iso file, then when it's done you can close QEMU and run `./rainymac.sh`.
* You can also do the installation by enabling cdrom in the config, setting boot device to d, and setting it back to c after the installation.

# Changing screen resolution
You'll quickly notice that the screen resolution is very low, 800x600. You can change it in System Preferences > Displays
![screen resolution](/screenshots/screenshot3.png)

# Networking
You can enable or disable networking in the config if desired.

# VNC connection
You can enable VNC in the `rainymac.cfg`. 
Here's a screenshot of connecting to the emulated machine via VNC:
![vnc](/screenshots/screenshot4.png)

# SSH connection
If you want to ssh into the emulation you can enable `ssh_forwarding` in the config.

Enabling SSH in OS X:
* Open System Preferences
![system preferences](/screenshots/screenshot1.png)
* Go to Sharing
![remote login](/screenshots/screenshot2.png)
* Enable "Remote Access"

SSH into the emulation with this command:
```
ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -c 3des-cbc localhost -p 5555
```

# Audio in Tiger/Leopard
* In OS X 10.4-10.4.3 it works out of the box, in anything higher you will need to do some work.
Refer to one of my past blog posts:
https://alicela1n.github.io/osx-10.5-ppc-in-qemu-with-working-audio
* Enable audio by setting `usbaudio="on"` in `rainymac.cfg`

# Installing Xcode and developer tools in OS X Tiger
Requires dmg2img to be installed
* Download [Xcode 2.5](https://download.developer.apple.com/Developer_Tools/xcode_2.5_developer_tools/xcode25_8m2558_developerdvd.dmg) from Apple's website.
* Convert to img like so ``dmg2img ~/Downloads/xcode25_8m2558_developerdvd.dmg xcode.img``
* Run ``./install.sh --stage2`` and point to xcode.img for iso path
* Install `Xcode Tools.pkg`, with how slow this is it's normal to take a long time
![xcode installing](/screenshots/screenshot5.png)
* Shut down the emulation and start it with `./rainymac.sh`

# File transfer
File transfer is something that's always been a problem with running legacy operating systems in virtual machines. Most methods are either insecure or flat out don't work. File transfer can be achieved in multiple ways, such as running an FTP server on the host, which is what I usually do, however this isn't very secure.

You can also transfer files over SSH, not very secure but it works. However you shouldn't expect security from an ancient operating system in the first place. Example: `scp -oKexAlgorithms=+diffie-hellman-group1-sha1 -c 3des-cbc -P 5555 ~/Downloads/MacPorts-2.6.4-10.4-Tiger.dmg alice@localhost:~/Desktop`

You can also use a disk image formatted as hfsplus or fat32. Copy your files to that disk image then pass it to QEMU. Since this is more advanced I won't cover that.

# Installing MacPorts
I prefer MacPorts over Tigerbrew for a lot of reasons, it's more compatible and has more packages. Thankfully MacPorts still supports Mac OS X 10.4! You can install it with the MacPorts package from [GitHub](https://github.com/macports/macports-base/releases/download/v2.6.4/MacPorts-2.6.4-10.4-Tiger.dmg)!

You can install packages with `sudo port install`.

# Installing Tigerbrew
Open Terminal or use ssh and run the following commands:
Install Tigerbrew using this command:
```
$ ruby -e "$(curl -fsSkL raw.github.com/mistydemeo/tigerbrew/go/install)"
```
Add the path to your bash_profile with this command:
```
$ echo "export PATH=/usr/local/sbin:/usr/local/bin:$PATH" >> ~/.bash_profile
```
Install packages using `brew install` or get help with `brew help`.
