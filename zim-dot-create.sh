#! /bin/bash
if zenity --question --text="Möchten Sie ein Diagramm erstellen?"
then
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
filename=${File%.*}
mkdir -p "$filename"
noweb.py -Rdiagram.dot "$File" > "$filename"/diagram.dot
dot -Tpng "$filename"/diagram.dot -o "$filename"/diagram.png
echo "{{./diagram.png?type=diagram}}"
#echo "$1" "$2" "$3" > ~/log.txt
fi
