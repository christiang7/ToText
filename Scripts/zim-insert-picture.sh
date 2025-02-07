#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
templateDir="$(config_get templateDir)"
wikiDir="$(config_get wikiDir)"
source tt-lib.sh

File=$(cleanName "$1")
filetxt=${File%.*}
datum=$(date +"%Y-%m-%d--%H-%M-%S")
abfrage=$(yad --title="Enter new filename" --text="Type new filename" \
		--form --width 500 --separator="~" --item-separator=","  \
		--field="Name" \
		"_${datum}")
if [ ! $? -eq 1 ];
then
	filename=$(echo $abfrage | cut -s -d "~" -f 1)
	filename=$(cleanName "$filename")
	if [ ! "$filename" = "" ];
	then
		mkdir -p "$filetxt"
		cd "$filetxt"
		cp $templateDir/Vorlage-Notiz.kra "$filename".kra
		xterm -e "krita "$filename".kra"
		krita "$filename".kra --export --export-filename "$filename".avif

		File=$(echo "$filename".kra)
		touch "$File".md
		echo "Content-Type: text/x-zim-wiki" >> "$File".md
		echo "Wiki-Format: zim 0.6" >> "$File".md
		echo "===== $File =====" >> "$File".md
		echo "[*] @NOTIZ @BILD **[[../"$filename".kra]] Christian Gößl **" >> "$File".md
		echo "Text creation time: $(date +"[[$journalPage:%Y:%m:%d]]")" >> "$File".md
		echo "Modification time: $(date +"[[$journalPage:%Y:%m:%d]]" -r "$1")" >> "$File".md
		echo -e "\n" >> "$File".md
		echo "{{../"$filename".avif?width=500}}" >> "$File".md
		echo -e "\n" >> "$File".md

		echo -e "[[+${filename}.kra]]"
		echo {{"$filename".avif?width=500}}
	fi
fi
