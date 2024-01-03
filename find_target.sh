#!/bin/bash

for dir in `ls /media/root`; do
	subdirs=(`ls /media/root/$dir`)
	if [[ $(echo ${subdirs[@]} | grep -w "Users") ]]; then
		echo "/media/root/$dir/Users" >> /home/kali/pahest/temp/targets.txt
	elif [[ $(echo ${subdirs[@]} | grep -w "home") ]]; then
		echo "/media/root/$dir/home" >> /home/kali/pahest/temp/targets.txt
	else
		echo "/media/root/$dir" >> /home/kali/pahest/temp/targets.txt
	fi
done


