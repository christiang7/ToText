#!/bin/bash

File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
filetxt=${File%.*}
filetxtname=$(basename "$File" .md)
filedate=$(date +"%Y-%m-%d")
source="Christian Gößl"
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
	if [[ $2 == Notiz ]]
	then
		echo "Content-Type: text/x-zim-wiki" >> "$File".md
		echo "Wiki-Format: zim 0.6" >> "$File".md
		echo "===== $File =====" >> "$File".md
		echo "[*] **[[../"$filename".xopp]] $source**" >> "$File".md
		echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" >> "$File".md
		echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$File")" >> "$File".md
		echo -e "\n" >> "$File".md
		ttpdf "$filename".pdf
		echo -e "{{../$File.avif?width=750}}\n" >> "$File".md
		xournalpp --export-range=1 "$File" -i "$File".png
		convert "$File".png "$File".avif
		rm "$File".png
	fi
fi
