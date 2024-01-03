#!/bin/bash

cat /home/kali/pahest/temp/to_mount.txt | while read line; do
	udisksctl mount -b "/dev/$line"
done
