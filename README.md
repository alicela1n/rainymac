# rainymac
Easy setup PPC versions of Mac OS X in QEMU!

# Requirements
* A decent processor, otherwise performance is terrible
* > 1GB RAM unless you adjust the configuration
* At least 10GB of drive space, 32 or up recommended
* ISO of the version of OS X you want, you can download Tiger with ``./download-osx.sh``

# Installation
If you don't already have an iso you can download Tiger by running ``./download-osx.sh``.
* For easy installation run ``./install.sh`` and give it the path to your iso file, then when it's done you can close QEMU and run ``./rainymac.sh``.
* You can also do the installation by enabling cdrom in the config, setting boot device to d, and setting it back to c after the installation.

# Networking
You can enable or disable networking in the config if desired.

# SSH connection
If you want to ssh into the emulation you can enable ``ssh_forwarding`` in the config.

Enabling SSH in OS X:
* Open System Preferences
![system preferences](/screenshots/screenshot1.png)
* Go to Sharing
![remote login](/screenshots/screenshot2.png)
* Enable "Remote Access"

SSH into the emulation with this command:
```
Connect using ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -c 3des-cbc localhost -p 5555
```
