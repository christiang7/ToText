#!/bin/bash
#if zenity --question --text="Möchten Sie eine neue Skizze anfertigen?"
#then
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
filetxt=${File%.*}
#echo $filetxt
datum=$(date +"%Y-%m-%d--%H-%M-%S")
Newname=$(zenity --entry \
       --width 500 \
       --title "Type new filename" \
       --text "Enter new filename" \
       --entry-text "${datum}_")
if [ ! "$Newname" = "" ];
then
	filename=$(echo "$Newname" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
	mkdir -p "$filetxt"
	cd "$filetxt"
	#echo "cp ~/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/ZetteL/Vorlagen/Vorlage-Notiz.avif "$filename".avif"
	cp ~/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/ZetteL/Vorlagen/Vorlage-Notiz.avif "$filename".avif
	#mypaint "$filename".png
	xterm -e "krita "$filename".avif"
	ttpic "$filename".avif
	echo -e "[[+${filename}.avif]]"
	echo {{"$filename".avif?width=750}}
fi
