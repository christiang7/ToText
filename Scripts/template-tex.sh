#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
templateDir="$(config_get templateDir)"
langName="$(config_get langName)"
author="$(config_get author)"
source tt-lib.sh;

yadSwitch=$2

if [[ ! -e "$1" ]]
then
	folder=$(pwd)
else
	filetxt=$(readlink -f -n "$1")
	folder=${filetxt%.*}
	mkdir -p "$folder"
fi
cd "$folder"
echo "$folder"

if [[ $yadSwitch == "" ]]
then
	abfrage=$(yad --title="New Latex File" --text="Necessary Informations:" \
		--form --width 500 --separator="~" --item-separator=","  \
		--field="Filename:" \
		--field="Which template:":CB \
		--field="Shortname for language":CBE \
		--field="Author:":CBE \
		--field="Tags:":CBE \
		--field="Git init?":CB \
		--field="Description:":TXT \
		"" "Programming,normal,Rechnung,Schreiben" "$langName" "$author,Internet" ",physic,math" "No,Yes" "")
fi
if [ ! $? -eq 1 ];
then
	if [[ $yadSwitch == "" ]]
    then
		filename=$(echo $abfrage | cut -s -d "~" -f 1)
		template=$(echo $abfrage | cut -s -d "~" -f 2)
		langname=$(echo $abfrage | cut -s -d "~" -f 3)
		source=$(echo $abfrage | cut -s -d "~" -f 4)
		tags=$(echo $abfrage | cut -s -d "~" -f 5)
		gitinit=$(echo $abfrage | cut -s -d "~" -f 6)
		additiontext=$(echo $abfrage | cut -s -d "~" -f 7)
	else
		filename=$3
		template=$4
		tags=$5
		source=$6
		additiontext=$7
		gitinit=$8
		langname=$9
	fi
	title="$filename"
	filename=$(cleanName "$filename")
	#folder=.

	foldertex="$filename"_tex
	mkdir -p "$foldertex"
	cp $templateDir/general-preamble.tex "$foldertex"/general-preamble.tex
	cp $templateDir/color-style.tex "$foldertex"/color-style.tex
	if [[ ${template} == "Programming" ]]
	then
		extens="$(get-extens ${langname})"
		add="[[./"${filename}".${extens}]]\n"
	fi

	create-note "$folder" "$foldertex" "@LATEX $tags" "" "$add[[./$filename.md]]\n[[./$filename.tex]]\n[[./$filename.pdf]]" >> "$folder"/"$foldertex".md

	markdown-description-program "${filename}" >> "$folder"/"$foldertex"/"${filename}".md

	File="${filename}.tex"
	case ${template} in
		normal)
		cp "$templateDir"/normal-template.tex "$folder"/"$foldertex"/"${File}"

		tex-description "$folder" "${File}" "$foldertex" "$additiontext" >> "$folder"/"$foldertex"/"${filename}".md
			;;
        Rechnung)
		cp "$templateDir"/Rechnung-template.tex "$folder"/"$foldertex"/"${File}"

		tex-description "$folder" "${File}" "$foldertex" "$additiontext" >> "$folder"/"$foldertex"/"${filename}".md

			;;
		Schreiben)
		cp "$templateDir"/Schreiben-template.tex "$folder"/"$foldertex"/"${File}"

		tex-description "$folder" "${File}" "$foldertex" "$additiontext" >> "$folder"/"$foldertex"/"${filename}".md

            ;;
		Programming)

		cp "$templateDir"/programming-template.tex "$folder"/"$foldertex"/"${File}"

		tex-description "$folder" "${File}" "$foldertex" "$additiontext\n\\\begin{minted}[linenos=true,bgcolor=lightgraycolor,numberblanklines=true,showspaces=false,breaklines=true]{${langname}}\n#*${filename}.${extens}}}\n\\\end{minted}" "#*run code}}" >> "$folder"/"$foldertex"/"${filename}".md

		template-code "$folder/$foldertex" "${filename}.${extens}" "${filename}.tex" "yes" >> "$folder"/"$foldertex"/"${filename}".md

			;;
	esac
	if [[ $gitinit == "Yes" ]];
	then
		cd "$foldertex"
		git init
		git add *
		git commit -a -m "init git"
	fi

fi

