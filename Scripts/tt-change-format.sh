#!/bin/bash
File=$(basename "$1")
extensmd=${File##*.}
Filename=${File%.*} #here it is the original file
extens=${Filename##*.} # and the original file extension
folder=$(basename "$Filename" ."$extens")
name=${Filename%.*}

mkdir "$folder"
mv "$Filename" "$folder"/"$Filename"
mv "$Filename.avif" "$folder"/"$Filename.avif"
mv "$Filename.png" "$folder"/"$Filename.png"
mv "$name.de.vtt" "$folder"/"$Filename.de.vtt"
mv "$name.en.vtt" "$folder"/"$Filename.en.vtt"
mv "$name.ttml" "$folder"/"$Filename.ttml"
mv "$name.vtt" "$folder"/"$Filename.vtt"
mv "${Filename%.*}" "$folder"/"$Filename"
mv "${Filename%.*}"_files "$folder"/"$Filename"_files
mv "${Filename%.*}"-Dateien "$folder"/"$Filename"-Dateien
mv "${Filename%.*}"_Dateien "$folder"/"$Filename"_Dateien
mv "$folder" "$folder.$extens"
folder="$folder.$extens"
sed -i "s/..\/$Filename/.\/$Filename/g" "$File"
