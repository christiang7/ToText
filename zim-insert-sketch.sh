#!/bin/bash
source config.sh; # load the config library functions
source tt-lib.sh;

#if zenity --question --text="Möchten Sie eine neue Skizze anfertigen?"
#then
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
filetxt=${File%.*}

datum=$(date +"%Y-%m-%d--%H-%M-%S")
Newname=$(zenity --entry \
	--width 500 \
	--title "Type new filename" \
	--text "Enter new filename" \
	--entry-text "_${datum}")
if [ ! "$Newname" = "" ];
then
	filename=$(cleanName "$Newname")
	#filename=$(echo "$Newname" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
	mkdir -p "$filetxt"
	cd "$filetxt"
	mypaint "$filename".png
	ttpic "$filetxt" "$filename".png "" "" ""
	echo -e "[[+${filename}.png]]"
	echo {{"$filename".png?width=500}}
fi
#fi
