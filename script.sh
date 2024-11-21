#!/bin/bash

systemctl disable DiskReader.service
path="/home/kali"
mkdir $path/temp

lsblk > $path/temp/lsblk.txt
/usr/bin/python $path/main.py "$path/temp/lsblk.txt" "$path/temp/to_mount.txt"

cat `pwd`/temp/to_mount.txt | while read line; do
	udisksctl mount -b "/dev/$line"
done

for dir in `ls /media/root`; do
	subdirs=(`ls /media/root/$dir`)
	if [[ $(echo ${subdirs[@]} | grep -w "Users") ]]; then
		echo "/media/root/$dir/Users" >> $path/temp/targets.txt
	elif [[ $(echo ${subdirs[@]} | grep -w "home") ]]; then
		echo "/media/root/$dir/home" >> $path/temp/targets.txt
	else
		echo "/media/root/$dir" >> $path/temp/targets.txt
	fi
done

cat $path/temp/targets.txt | while read line; do
	./gf.out $line
	IFS=$'\n'
	if [ -s $main_path/temp/readable_files.txt ]; then
        	tar zcf "$( basename $line ).tar.gz" `cat $main_path/temp/readable_files.txt`
	fi
	rm -f $main_path/temp/readable_files.txt

done

count=$(ls -l $path | grep ^d | wc -l)
echo $count
dir="res$(( $count + 1 ))"
mkdir $path/$dir
mv $path/*.tar.gz  $path/$dir

rm -r $path/temp

