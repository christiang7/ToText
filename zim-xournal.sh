#!/bin/bash
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
filetxt=${File%.*}
filetxtname=$(basename "$File" .md)
filedate=$(date +"%Y-%m-%d")
source="Christian Gößl"
par="$(echo $2)"
if [[ "Notiz" != "$par" ]];
then
    additontext="$2"
else
    additontext="$2-$filetxtname"
    #echo ifNotiz >> log.md
fi
Newname=$(zenity --entry \
    --width 500 \
    --title "Type new filename" \
    --text "Enter new filename" \
    --entry-text "$filedate-$additontext")
if [ ! "$Newname" = "" ];
then
    mkdir -p "$filetxtname"
    cd "$filetxtname"
    filename=$(echo "$Newname" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
    File=$(echo "$filename".xopp)
    xournalpp "$filename".xopp && xournalpp "$File" -p "$filename".pdf
    if [ "Unterrichtsnotiz" != "$par" ]; then
        echo "Content-Type: text/x-zim-wiki" >> "$File".md
        echo "Wiki-Format: zim 0.6" >> "$File".md
        echo "====== $File ======" >> "$File".md
        echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]") Modification time: $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]" -r "$File")" >> "$File".md
        echo "[*] **[[../"$filename".xopp]] **" >> "$File".md
        echo "$source" >> "$File".md
        #ttpdf "$filename".pdf
        #echo -e "{{../$File.avif?width=500}}\n" >> "$File".md
        #xournalpp --export-range=1 "$File" -i "$File".png
        #convert "$File".png "$File".avif
        #rm "$File".png
    fi
fi
