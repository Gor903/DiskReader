#!/bin/bash

main_path="/home/kali/pahest"
touch $main_path/open_paths.txt $main_path/closed_paths.txt
ignored_directories=(".local" "virtualenv" ".gradle" "" ".git" ".config" ".cache" "64E3-8E07" "EFI" "." ".." "Gradle" "NDK" "Logs" "Application Data" "SendTo" "Recent" "Links" "IntelGraphicsProfiles" "AppData" "venv" "__pycache__" "Library" "Start Menu")
ignored_extensions=("cache" "meta" "mui" "etl" "xml" "log" "bin" "msi" "dat" "LOG1" "LOG2" "ini" "exe" "dll" "url" "igpi" "search-ms" "lnk" "iso")
function file {
	local file_path=$1
	echo "$file_path" >> $main_path/open_paths.txt
}

function add_cant_read {
	local file_path=$1
	echo "$file_path" >> $main_path/closed_paths.txt
}

function check_dir {
	local dir="$1"
	cd "$dir"
	ls -a | while read res_nm; do
		res="$(echo $res_nm | sed 's/ /\\ /g')"
		path="$dir/$res"
		if [ -d "$path" ]; then
			if [[ ${ignored_directories[@]} =~ "$res_nm" ]]; then
				continue
			fi
			if [ ! -x "$path" ] || [ ! -r "$path" ]; then
				add_cant_read "$path"
				continue
			fi
			check_dir "$path"
		else
			if [[ ${ignored_extensions[@]} =~ "${res_nm##*.}" ]]; then
	                        add_cant_read "$path"
        	                continue
                	fi

			if [ -r "`pwd`/$res_nm" ]; then
				file "`pwd`/$res_nm"
				continue
			else
				add_cant_read "$path"
			fi
		fi
	done
	cd ..
}
check_dir "$1"
cd $main_path
IFS=$'\n'
if [ -s $main_path/open_paths.txt ]; then
	tar zcf "$2.tar.gz" `cat $main_path/open_paths.txt`
fi
rm -f $main_path/open_paths.txt
