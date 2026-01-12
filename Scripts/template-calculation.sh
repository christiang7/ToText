#!/bin/bash
source config.sh
source tt-lib.sh
langName="$(config_get langName)"
author="$(config_get author)"

typ=$(yad --title="New calculation?" --text="Necessary Informations:" \
	--form --width 500 --separator="" --item-separator=","  \
	--field="Type of calculation":CB \
	"Standalone File,Project")
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
	case ${typ} in
	"Standalone File")
		File="Filename"

		abfrage=$(yad --title="New calculation?" --text="Necessary Informations:" \
			--form --width 500 --separator="~" --item-separator=","  \
			--field="Filename" \
			--field="Shortname for language":CBE \
			--field="Author":CBE \
			--field="Tags":CBE \
			--field="Description":TXT \
			"$File" "$langName" "$author,Internet" ",physic,math" "$additiontext")
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


			markdown-description-program "${Filename}.${extens}" >> "$folder"/"${Filename}.${extens}".md

			template-code "$folder" "${Filename}.${extens}" >> "$folder"/"${Filename}.${extens}".md


		fi

		;;
	Project)
		template-calculation-project.sh "$1"
		;;
	esac
	notify-send -a "template-calculation.sh created $File" "" "$(date +"%Y-%m-%d") fertig"
fi
