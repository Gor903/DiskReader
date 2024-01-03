#!/bin/bash

cat /home/kali/pahest/temp/targets.txt | while read line; do
	bash /home/kali/pahest/gf.sh $line $( basename $line )
done
