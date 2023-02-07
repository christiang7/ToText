#!/bin/bash
if zenity --question --text="Möchten Sie Treesheets öffnen?"
then
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
filetxt=${File%.*}
mkdir -p "$filetxt"
cd "$filetxt"
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
filename=$(echo "$Newname" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
cp ~/Gedankenspeicher/Vorlagen/Vorlage-10-10.cts "$filename".cts
cp ~/Gedankenspeicher/Vorlagen/Vorlage-10-10.png "$filename".cts.png
treesheets "$filename".cts && ttn "$filename".cts
fi
