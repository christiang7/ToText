#!/bin/bash
source tt-lib.sh
langName="$(config_get langName)"

yad --title="New calculation?" --text="\n Standalone File?\n"
if [ ! $? -eq 1 ];
then
  if [[ ! -e "$1" ]]
  then
	folder=$(pwd)
	#echo $folder
  else
	filetxt=$(readlink -f -n "$1")
	folder=${filetxt%.*}
	#echo $folder
	mkdir -p "$folder"
  fi
  File="Filename"
  cd $folder

  abfrage=$(yad --title="New calculation?" --text="Necessary Informations:" \
  	--form --width 500 --separator="~" --item-separator=","  \
  	--field="Filename" \
  	--field="Shortname for language":CBE \
  	--field="Author":CBE \
  	--field="Tags":CBE \
  	--field="Description":TXT \
  	"$File" "$langName" "Christian Gößl,Internet" ",physic,math" "$additiontext")
  if [ ! $? -eq 1 ];
  then
  	File=$(echo $abfrage | cut -s -d "~" -f 1)
  	langname=$(echo $abfrage | cut -s -d "~" -f 2)
  	source=$(echo $abfrage | cut -s -d "~" -f 3)
  	tags=$(echo $abfrage | cut -s -d "~" -f 4)
  	additiontext=$(echo $abfrage | cut -s -d "~" -f 5)
  	File=$(cleanName "$File")

  	extens="$(get-extens ${langname})"

  	Filename="$File"
  	File="$File"."${extens}"


  	markdown-description-program "$folder" "${Filename}.${extens}"

  	program-template "$folder" "${Filename}.${extens}"


  fi

else
  zim-template-calculation.sh "$1"
  #echo 2
fi
