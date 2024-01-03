#!/bin/bash

sudo systemctl disable get_info.service
mkdir /home/kali/pahest/temp
lsblk > /home/kali/pahest/temp/lsblk.txt
/usr/bin/python /home/kali/pahest/main2.py "/home/kali/pahest/temp/lsblk.txt" "/home/kali/pahest/temp/to_mount.txt"
bash /home/kali/pahest/mount.sh
chmod 777 /media/root
bash /home/kali/pahest/find_target.sh
bash /home/kali/pahest/start_gf.sh
bash /home/kali/pahest/move.sh
sudo rm -r /home/kali/pahest/temp
