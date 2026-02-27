#!/usr/bin/env bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
author="$(config_get author)"
source tt-lib.sh;

if [[ ! -e "$1" ]]
then
  folder=$(pwd)
  echo $folder
else
  folder=$(basename "$1")
  echo $folder
fi

abfrage=$(yad --title="Note with folder" --text="Something to add?" \
	--form --width 500 --separator="~" --item-separator=","  \
    --field="Name" \
	--field="Tags" \
	--field="Quelle:":CBE \
	--field="Weiteres":TXT \
	"" "" "$author,Internet," "")
if [ ! $? -eq 1 ];
then
    name=$(echo $abfrage | cut -s -d "~" -f 1)
	tags=$(echo $abfrage | cut -s -d "~" -f 2)
	source=$(echo $abfrage | cut -s -d "~" -f 3)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 4)

    create-note "${folder}" "${name}" "$tags" "$source" "$additiontext" >> "${folder}"/"${name}".md
    notify-send -a "Note created" "" "$(date +"%Y-%m-%d") fertig"
fi
