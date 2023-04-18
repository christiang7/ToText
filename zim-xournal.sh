#!/bin/bash

File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
filetxt=${File%.*}
filetxtname=$(basename "$File" .txt)
filedate=$(date +"%Y-%m-%d")
source="Christian Gößl"
tags="@Unterricht @Nachhilfe"
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
	File=$(echo "$filename".xopp)
	xournalpp "$filename".xopp && xournalpp "$File" -p "$filename".pdf
	echo "Content-Type: text/x-zim-wiki" >> "$File".txt
	echo "Wiki-Format: zim 0.6" >> "$File".txt
	echo "===== $File =====" >> "$File".txt
	echo "[*] $tags **[[../"$filename".xopp]] $source**" >> "$File".txt
	echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" >> "$File".txt
	echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$File")" >> "$File".txt
	echo -e "[[../]]\n" >> "$File".txt
	xournalpp --export-range=1 "$File" -i "$File".png
	convert "$File".png "$File".avif
	rm "$File".png
	echo -e "{{../$File.avif?width=750}}\n" >> "$File".txt
	ttpdf "$filename".pdf
fi


