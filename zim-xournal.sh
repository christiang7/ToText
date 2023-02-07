#!/bin/bash
#if zenity --question --text="Möchten Sie dieses Programm: Xournalpp öffnen?"
#then

File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
filetxt=${File%.*}
filetxtname=$(basename "$File" .txt)
filedate=$(date +"%Y-%m-%d")
if [[ $2 == Notiz ]]
then
	additontext="$2"
else
	additontext="$2-$filetxtname"
fi
Newname=$(zenity --entry \
       --width 500 \
       --title "Type new filename" \
       --text "Enter new filename" \
       --entry-text "$filedate-$additontext")
if [ ! "$Newname" = "" ];
then
	mkdir -p "$filetxt"
	cd "$filetxt"
	filename=$(echo "$Newname" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
	xournalpp "$filename".xopp && ttn "$filename".xopp
fi

