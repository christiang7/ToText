#!/usr/bin/env bash

ttrename "$1"

folder=$(readlink -f -n "$1")
file=$(basename "$folder" .txt)

folder="${folder%/*}"


assetsfolder=$(echo ~/Gedankenspeicher/Gedankenspeicherwiki/Assets)
wikipath=$(echo $assetsfolder | sed "s,/home/christian/Gedankenspeicher/Gedankenspeicherwiki/,," | sed "s,/,:,g")

mv "$folder"/"$file" "$assetsfolder"/"$file"
mv "$folder"/"$file".png "$assetsfolder"/"$file".png
mv "$folder"/"$file".avif "$assetsfolder"/"$file".avif
mv "$folder"/"$file".txt "$assetsfolder"/"$file".txt

echo -e "[[$assetsfolder/$file]]\n[[$wikipath:$file]]" >> "$assetsfolder"/"$file".txt
