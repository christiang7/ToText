#!/usr/bin/env bash


chooseWhere=$(zenity --height 450 --list --radiolist --print-column ALL --hide-header --column "Checkbox" --column "What" TRUE Spass FALSE Assets FALSE KanDo FALSE Physik FALSE Mathematik FALSE Philosophie FALSE Naturwissenschaften_und_Instrumentarien FALSE CodeFabrik FALSE Zitat FALSE Privat FALSE Kyudo FALSE HSP FALSE Zettelkasten)

if [ ! $? -eq 1 ];
then
    folder=$(readlink -f -n "$1")
    folder="${folder%/*}"

    #filename=$(ttrename "$1" 2> /dev/null)

    filename=$(basename "$1" .md)

    echo $folder
    echo $filename

    #filename=${file%.*}
    case ${chooseWhere} in
	Spass) assetsfolder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Spaß_Stream")
		;;
	Assets) assetsfolder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Assets")
		;;
	Physik) assetsfolder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Physik")
		;;
	Mathematik) assetsfolder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Mathematik")
		;;
	Philosophie) assetsfolder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Philosophie")
		;;
	Naturwissenschaften_und_Instrumentarien) assetsfolder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Naturwissenschaften_und_Instrumentarien")
		;;
    KanDo) assetsfolder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Artelier/KanDo")
		;;
	CodeFabrik) assetsfolder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik")
		;;
	Zettelkasten) assetsfolder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten")
		;;
    Zitat) assetsfolder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/ZitaT")
		;;
    Privat) assetsfolder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Privat")
		;;
    Kyudo) assetsfolder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Spaß_Stream/Kyudo")
		;;
    HSP) assetsfolder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Spaß_Stream/Hochsensibilität")
		;;
    esac
    #assetsfolder=$(echo ~/Gedankenspeicher/Gedankenspeicherwiki/Assets)
    wikipath=$(echo $assetsfolder | sed "s,/home/christian/Gedankenspeicher/Gedankenspeicherwiki/,," | sed "s,/,:,g")

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
