#!/usr/bin/env bash
source config.sh; # load the config library functions
GedankenspeicherwikiDir="$(config_get GedankenspeicherwikiDir)"

chooseWhere=$(zenity --height 450 --list --radiolist --print-column ALL --hide-header --column "Checkbox" --column "What" TRUE Spass FALSE Assets FALSE KanDo FALSE Physik FALSE Mathematik FALSE Philosophie FALSE Naturwissenschaften_und_Instrumentarien FALSE CodeFabrik FALSE Zitat FALSE Lebenswerkstatt FALSE Kyudo FALSE HSP FALSE Zettelkasten)

if [ ! $? -eq 1 ];
then
	folder=$(readlink -f -n "$1")
	folder="${folder%/*}"

	#filename=$(ttrename "$1" 2> /dev/null)

	filename=$(basename "$1" .md)

	#echo $folder
	#echo $filename

	#filename=${file%.*}
	case ${chooseWhere} in
	Spass) assetsfolder=$(echo "$GedankenspeicherwikiDir/Spaß_Stream")
		;;
	Assets) assetsfolder=$(echo "$GedankenspeicherwikiDir/Assets")
		;;
	Physik) assetsfolder=$(echo "$GedankenspeicherwikiDir/Physik")
		;;
	Mathematik) assetsfolder=$(echo "$GedankenspeicherwikiDir/Mathematik")
		;;
	Philosophie) assetsfolder=$(echo "$GedankenspeicherwikiDir/Philosophie")
		;;
	Naturwissenschaften_und_Instrumentarien) assetsfolder=$(echo "$GedankenspeicherwikiDir/Naturwissenschaften_und_Instrumentarien")
		;;
	CodeFabrik) assetsfolder=$(echo "$GedankenspeicherwikiDir/CodeFabrik")
		;;
	Zettelkasten) assetsfolder=$(echo "$GedankenspeicherwikiDir/Zettelkasten")
		;;
	Zitat) assetsfolder=$(echo "$GedankenspeicherwikiDir/Zettelkasten/ZitaT")
		;;
	Lebenswerkstatt) assetsfolder=$(echo "$GedankenspeicherwikiDir/Zettelkasten/Lebenswerkstatt")
		;;
	Kyudo) assetsfolder=$(echo "$GedankenspeicherwikiDir/Spaß_Stream/Kyudo")
		;;
	HSP) assetsfolder=$(echo "$GedankenspeicherwikiDir/Spaß_Stream/Hochsensibilität")
		;;
	esac
	#assetsfolder=$(echo ~/Gedankenspeicher/Gedankenspeicherwiki/Assets)
	wikipath=$(echo $assetsfolder | sed "s,$GedankenspeicherwikiDir,," | sed "s,/,:,g")

	mv "$folder"/"$filename" "$assetsfolder"/"$filename"
	#mv "$folder"/"$file" "$assetsfolder"/"$file"

	mv "$folder"/"${filename}"_files "$assetsfolder"/"${filename}"_files
	mv "$folder"/"${filename}"-Dateien "$assetsfolder"/"${filename}"-Dateien
	mv "$folder"/"${filename}"_Dateien "$assetsfolder"/"${filename}"_Dateien

	mv "$folder"/"$filename".png "$assetsfolder"/"$filename".png
	mv "$folder"/"$filename".avif "$assetsfolder"/"$filename".avif
	mv "$folder"/"$filename".md "$assetsfolder"/"$filename".md

	#echo -e "[[$assetsfolder/$filename]]\n[[$wikipath:$filename]]" >> "$assetsfolder"/"$filename".md
fi
