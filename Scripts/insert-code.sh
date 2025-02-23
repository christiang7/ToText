#!/bin/bash
source tt-lib.sh
source config.sh
langName="$(config_get langName)"

txtfile=$(readlink -f -n "$1")
folder=${txtfile%.*}
txtfile=$(basename "$txtfile")
txtfilename=${txtfile%.*}
#echo $folder

abfrage=$(yad --title="Insert code?" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Filename" \
	--field="Shortname for language":CBE \
	--field="Add to existing code":CB \
	"" "$langName" ",yes")
if [ ! $? -eq 1 ];
then
	mkdir -p "$folder"
	File=$(echo $abfrage | cut -s -d "~" -f 1)
	langname=$(echo $abfrage | cut -s -d "~" -f 2)
	add=$(echo $abfrage | cut -s -d "~" -f 3)

	File=$(cleanName "$File")

	extens="$(get-extens ${langname})"

	Filename="$File"
	File="$File"."${extens}"


	template-code "." "${Filename}.${extens}" "${txtfilename}" "$add"

fi
