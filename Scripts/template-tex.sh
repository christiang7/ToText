#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
templateDir="$(config_get templateDir)"
langName="$(config_get langName)"
source tt-lib.sh;

if [[ ! -e "$1" ]]
then
	folder=$(pwd)
else
	filetxt=$(readlink -f -n "$1")
	folder=${filetxt%.*}
	mkdir -p "$folder"
fi
#cd $folder


abfrage=$(yad --title="New Latex File" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Filename:" \
	--field="Which template:":CB \
	--field="Shortname for language":CBE \
	--field="Author:":CBE \
	--field="Tags:":CBE \
	--field="Git init?":CB \
	--field="Description:":TXT \
	"" "Programming,normal,Rechnung,Schreiben,Bewerbung" "$langName" "Christian Gößl,Internet" ",physic,math" "No,Yes" "$additiontext")

if [ ! $? -eq 1 ];
then
	filename=$(echo $abfrage | cut -s -d "~" -f 1)
	template=$(echo $abfrage | cut -s -d "~" -f 2)
	langname=$(echo $abfrage | cut -s -d "~" -f 3)
	source=$(echo $abfrage | cut -s -d "~" -f 4)
	tags=$(echo $abfrage | cut -s -d "~" -f 5)
	gitinit=$(echo $abfrage | cut -s -d "~" -f 6)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 7)
	title="$filename"
	filename=$(cleanName "$filename")
	#folder=.

	foldertex="$filename"_tex
	mkdir -p "$foldertex"
	cp $templateDir/general-preamble.tex "$foldertex"/general-preamble.tex
	cp $templateDir/color-symbols.tex "$foldertex"/color-symbols.tex
	if [[ ${template} == "Programming" ]]
	then
		extens="$(get-extens ${langname})"
		add="[[./"${filename}".${extens}]]\n"
	fi

	create-note "$folder" "$foldertex" "@LATEX $tags" "" "$add[[./$filename.md]]\n[[./$filename.tex]]\n[[./$filename.pdf]]"

	markdown-description-program "$folder/$foldertex" "${filename}"

	File="${filename}.tex"
	case ${template} in
		normal)
		cp "$templateDir"/normal-template.tex "$folder"/"$foldertex"/"${File}"

		tex-description "$folder" "${File}" "$foldertex" "$additiontext"
			;;
        Rechnung)
		cp "$templateDir"/Rechnung-template.tex "$folder"/"$foldertex"/"${File}"

		tex-description "$folder" "${File}" "$foldertex" "$additiontext"

			;;
        Bewerbung)
		cp "$templateDir"/normal-template.tex "$folder"/"$foldertex"/"${File}"

		tex-description "$folder" "${File}" "$foldertex" "$additiontext"
            ;;
		Schreiben)
		cp "$templateDir"/Schreiben-template.tex "$folder"/"$foldertex"/"${File}"

		tex-description "$folder" "${File}" "$foldertex" "$additiontext"

            ;;
		Programming)

		cp "$templateDir"/programming-template.tex "$folder"/"$foldertex"/"${File}"

		tex-description "$folder" "${File}" "$foldertex" "$additiontext\n\\\begin{minted}[linenos=true,bgcolor=lightgraycolor,numberblanklines=true,showspaces=false,breaklines=true]{${langname}}\n#*${filename}.${extens}}}\n\\\end{minted}" "#*run program}}"

		program-template "$folder/$foldertex" "${filename}.${extens}" "${filename}.tex"


			;;
	esac
	if [[ $gitinit == "Yes" ]];
	then
		cd "$foldertex"

		git init
		git add "${filename}".md
		git add "${filename}".tex
		if [[ $template == "programming" ]];
		then
			git add ${filename}.${extens}
		fi
		git add general-preamble.tex
		git add color-symbols.tex
		git commit -a -m "init git"
	fi

fi

