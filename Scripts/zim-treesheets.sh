#!/bin/bash
source config.sh; # load the config library functions
templateDir="$(config_get templateDir)"
source tt-lib.sh

yad --title="Open treesheets?" --text="\n Open treesheets\n"
if [ ! $? -eq 1 ];
then
  File=$(cleanName "$1")
  filetxt=${File%.*}
  mkdir -p "$filetxt"
  cd "$filetxt"
  filetxtname=$(basename "$File" .md)
  filedate=$(date +"%Y-%m-%d")
  if [[ $2 == Notiz ]]
  then
      additontext="$2"
  else
      additontext="$2-$filetxtname"
  fi
  abfrage=$(yad --title="Enter new filename" --text="Type new filename" \
		--form --width 500 --separator="~" --item-separator=","  \
		--field="Name" \
		"$filedate-$additontext")
  if [ ! $? -eq 1 ];
  then
      filename=$(echo $abfrage | cut -s -d "~" -f 1)
      filename=$(cleanName "$filename")
      if [ ! "$filename" = "" ];
      then
        cp $templateDir/Vorlage-10-10.cts "$filename".cts
        cp $templateDir/Vorlagen/Vorlage-10-10.png "$filename".cts.png
        treesheets "$filename".cts && tt "$filename".cts
      fi
  fi
fi
