#!/bin/bash
source tt-lib.sh
inputDir="$(config_get wikiDir)"/Atelier

filename=$(yad --title="Save websession?" --text="\nSave copied tabs\n" \
	--form --width 500 --separator="" --item-separator=","  \
	--field="Filename:" \
	"2»websession_$(date +"%Y-%m-%d-%H-%M-%S")")
if [ ! $? -eq 1 ];
then
   filename=$(cleanName "$filename")
   echo "$inputDir"/"$filename".md
   echo "$(wl-paste -n)" >> "$inputDir"/"$filename".md
   notify-send -a "save-websession finished" "$filename" "$(cat ~/.config/tt/log)"
fi
