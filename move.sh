#!/bin/bash
count=$(ls -l /home/kali/pahest | grep ^d | wc -l)
echo $count
dir="res$(( $count + 1 ))"
mkdir /home/kali/pahest/$dir
mv /home/kali/pahest/closed_paths.txt /home/kali/pahest/*.tar.gz  /home/kali/pahest/$dir
