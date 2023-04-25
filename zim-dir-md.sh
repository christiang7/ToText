#! /bin/bash
if zenity --question --text="Möchten Sie dieses Programm: ttd ausführen?"
then
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
filename=${File%.*}
mkdir -p "$filename"
ttd "$filename"
fi
