#!/bin/bash
source config.sh; # load the config library functions
langName="$(config_get langName)"
author="$(config_get author)"
source tt-lib.sh

if [[ -e "$1" ]]
then
    filetxt=$(readlink -f -n "$1")
    folder=${filetxt%.*}
    #Project=$(basename $folder)
else
    #Project="Projectname"
    folder=$(pwd)
fi
#echo $folder
File="Filename"
Project="Projectname"

abfrage=$(yad --title="New Project calculation" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Projectname" \
	--field="Filename" \
	--field="Shortname for language":CB \
	--field="Author":CBE \
	--field="Tags":CBE \
	--field="Git init?":CB \
	--field="Description":TXT \
	"$Project" "$File" "$langName" "$author,Internet" ",physic,math" "Yes,No" "$additiontext")
if [ ! $? -eq 1 ];
then
	Project=$(echo $abfrage | cut -s -d "~" -f 1)
	File=$(echo $abfrage | cut -s -d "~" -f 2)
	langname=$(echo $abfrage | cut -s -d "~" -f 3)
	source=$(echo $abfrage | cut -s -d "~" -f 4)
	tags=$(echo $abfrage | cut -s -d "~" -f 5)
	gitinit=$(echo $abfrage | cut -s -d "~" -f 6)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 7)
	File=$(cleanName "$File")
    ProjectName="$Project"
    Project=$(cleanName "$Project")

    extens="$(get-extens ${langname})"

    Filename="$File"
    File="$File"."${extens}"

	mkdir -p "$folder"/"$Project"

	create-note "$folder" "$Project" "$tags" "$source" "$additiontext" >> "$folder"/"$Project".md

	markdown-description-program "README" >> "$folder/$Project"/"README".md

	markdown-description-program "${File}" >> "$folder/$Project"/"${File}".md

	template-code "$folder/$Project" "${File}" >> "$folder"/"$Project"/"${File}".md

	if [[ $gitinit == "Yes" ]];
	then
		cd "$folder/$Project"
		git init
		git add README.md
		git add "${File}".md
		git add ${Filename}.${extens}
		git commit -a -m "init git"
	fi
fi

