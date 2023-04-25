#!/usr/bin/env bash



folder=$(readlink -f -n "$1")
folder="${folder%/*}"

filename=$(ttrename "$1" 2> /dev/null)

#file=$(basename "$folder" .md)


#filename=${file%.*}

assetsfolder=$(echo ~/Gedankenspeicher/Gedankenspeicherwiki/Assets)
wikipath=$(echo $assetsfolder | sed "s,/home/christian/Gedankenspeicher/Gedankenspeicherwiki/,," | sed "s,/,:,g")

mv "$folder"/"$filename" "$assetsfolder"/"$filename"
#mv "$folder"/"$file" "$assetsfolder"/"$file"

mv "$folder"/"${filename}"_files "$assetsfolder"/"${filename}"_files
mv "$folder"/"${filename}"-Dateien "$assetsfolder"/"${filename}"-Dateien
mv "$folder"/"${filename}"_Dateien "$assetsfolder"/"${filename}"_Dateien

mv "$folder"/"$filename".png "$assetsfolder"/"$filename".png
mv "$folder"/"$filename".avif "$assetsfolder"/"$filename".avif
mv "$folder"/"$filename".md "$assetsfolder"/"$filename".md

echo -e "[[$assetsfolder/$filename]]\n[[$wikipath:$filename]]" >> "$assetsfolder"/"$filename".md
