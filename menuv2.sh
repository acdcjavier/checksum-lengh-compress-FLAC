#!/bin/bash
	echo "Choose"
	echo " "
	echo "1) st5 checksum"
	echo "2) calulate lengh [Total Minutes.Total Seconds]"
	echo "3) lz4 compression/decompression/Verify"
	echo "4) All-in-one (Checksum + lengh + compression tar.lz4)"
	echo "5) Check integrity of FLAC files"
	echo ""
	read opcion1

	checksum () {
		for d in */ ; do
		a=$d
		cd "$d"
		find . -type f -print0 -name '*.flac'| xargs -0 shntool hash > checksum.st5
		find . -name '*.st5' -size 0 -print0 | xargs -0 rm
		cd - 
		echo "$d"
		done
	}
	duration () {
		for d in */ ; do
		a=$d
		z="$(basename "$d")"
		cd "$d"
		var=$(find * -regex ".*\.\(flac\|mp3\|wav\|shn\)" | shntool len  | tail -n1 | tr ':' '.'| sed 's/^[ t]*//' | cut -d "." -f 1,2 )
		c=$z$"[$var]"
		if [ "$var" == '0.00' ]; then
			NEW_NAME="$(find . ".*\.\(flac\|mp3\|wav\|shn\)" | xargs exiftool -n -q -p '${Duration;our $sum;$_=ConvertDuration($sum+=$_)}' ".*\.\(flac\|mp3\|wav\|shn\)" | tail -n1 | tr ':' ' ' | awk -v ALBUM="$ALBUM" '
			{ total_minutes += $1 * 60 } # Accumulate hours
			{ total_minutes += $2 }      # Accumulate minutes
			{ total_seconds += $3 }      # Accumulate seconds
			END {
			total_minutes += int(total_seconds / 60)
			total_seconds = total_seconds % 60
			printf "%s[%d.%d]", ALBUM, total_minutes, total_seconds
			}
			')"
			b="$NEW_NAME"
			#echo "$NEW_NAME"
			c=$z$"$NEW_NAME"
		fi
		cd -
		#echo "[$var]"
		#echo "$z
		echo "$c"
		#echo "$d"
		mv -- "$z" "$c"
		done
	}
	compress () {
		for d in * ; do
		a=$d
		b=".tar.lz4"
		c=$a$b
		f=$e$b
		#echo "$d"
		#echo "$c"
		tar -cvf - "$a" | lz4 - "$c"
		find . -name "*.lz4" -size -10k -delete
		done
		exit 0
		
	}
	integrity () {
		for d in */ ; do
		a=$d
		cd "$d"
		echo "****************************"
		echo "analyzing:  $d"
		echo "****************************"
		find . -type f -name '*.flac' -print0 | xargs --null flac -tw
		cd - 
		echo "$d"
		done
	}
	if [ $opcion1 = 1 ]; then
		checksum
	fi
	if [ $opcion1 = 2 ]; then
		duration
	fi
	if [ $opcion1 = 3 ]; then
		echo "Choose"
		echo " "
		echo "1) Compress to tar.lz4"
		echo "2) Decompress tar.lz4 files "
		echo "3) Verify Integrity tar.lz4 files"
		echo ""
		read opcion2
		if [ $opcion2 = 1 ]; then
			compress
		fi
		if [ $opcion2 == 2 ]; then
			for d in *; do
			a=$d
			b=".tar.lz4"
			f=$e$b
			c=$a$b
			#echo "$d"
			lz4 -d "$d" | tar -xv
			#lz4 -d "$d" | tar xf -
			done
			exit 0
		fi
		if [ $opcion2 == 3 ]; then	
		find . -type f -name '*.lz4' | while read -r lz4; do
			lz4 -t "$lz4" 
		done
			#for d in * ; do
			#a=$d
			#b=".tar.lz4"
			#c=$a$b
			#lz4 -t "$d" 
			#done
			#exit 0
		fi
	fi
	if [ $opcion1 = 4 ]; then
		checksum
		duration
		compress
	fi
	if [ $opcion1 = 5 ]; then
		integrity
	fi
		
	
	
	
	
	
	
