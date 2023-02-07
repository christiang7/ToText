#! /bin/bash
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
filetxt=${File%.*}
mkdir -p "$filetxt"
cd "$filetxt"
filetxtname=$(basename "$File" .txt)
filedate=$(date +"%Y-%m-%d")
if [[ $2 == Notiz ]]
then
	additontext="$2"
else
	additontext="$2-$filetxtname"
fi
Newname=$(zenity --entry \
       --width 500 \
       --title "Type new filename" \
       --text "Enter new filename" \
       --entry-text "$filedate-$additontext")
filename=$(echo "$Newname" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
xournalpp "$filename".xopp && ttn "$filename".xopp
