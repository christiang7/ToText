#! /bin/bash
if zenity --question --text="Möchten Sie dieses Programm ein Screenshot aufnehmen?"
then
url="$1"
selecttext="$2"
#urltitle=$(wget -qO- "$url" | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)\s*<\/title/si' | recode html..)
urltitle=$(xidel -s "$url" --css title | tr -d '\n')
folder=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d")
mkdir -p $folder
filename=$(echo "Web-Screenshot-$urltitle" | sed 's/ /_/g' | sed 's/\//_/g' | sed 's/?/__/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g' | sed 's/\&/n/g' | sed -e "s/|//g" | sed 's/\[/(/g' | sed 's/\]/)/g')
File="$filename".png
scrot "$folder"/"$File" -s
foldermonth=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m")
calendarfile=$(date +"%d")
calendarfile=$calendarfile.txt
if [[ ! -e "$foldermonth"/"$calendarfile" ]]
then
	touch "$foldermonth"/"$calendarfile"
	echo "Content-Type: text/x-zim-wiki" >> "$foldermonth"/"$calendarfile"
  echo "Wiki-Format: zim 0.6" >> "$foldermonth"/"$calendarfile"
	date +"===== %A %d %b %Y =====" >> "$foldermonth"/"$calendarfile"
	date +"[[:Zettelkasten:%Y:Week %W|Week %W]]" >> "$foldermonth"/"$calendarfile"
	date +"[[Zettelkasten:%Y:%m]]" >> "$foldermonth"/"$calendarfile"
	echo -e "[[../]]"  >> "$foldermonth"/"$calendarfile"
	date +"[*] ** %A %d %b %Y ** >  2277-11-11" >> "$foldermonth"/"$calendarfile"
fi
tags=$(zenity --entry \
       --width 500 \
       --title "Noch Schlagwörter hinzufügen?" \
       --text "Noch Schlagwörter hinzufügen?" \
       --entry-text "$3")
additiontext=$(zenity --entry \
       --width 500 \
       --title "Noch etwas hinzufügen?" \
       --text "Noch etwas hinzufügen?" \
       --entry-text "$4")
touch "$File".txt
mv "$File".txt "$folder"/"$File".txt
echo "Content-Type: text/x-zim-wiki" >> "$folder"/"$File".txt
echo "Wiki-Format: zim 0.6" >> "$folder"/"$File".txt
echo "===== $File =====" >> "$folder"/"$File".txt
echo "[*] @BILD @Webseite @Screenshot $tags **[[../$File]] $url**" >> "$folder"/"$File".txt
echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" >> "$folder"/"$File".txt
echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$folder"/"$File")" >> "$folder"/"$File".txt
echo -e "[[../]]\n" >> "$folder"/"$File".txt
echo "{{../$File}}" >> "$folder"/"$File".txt
echo "$additiontext" >> "$folder"/"$File".txt
tesseract -l eng+deu "$folder"/"$File" stdout | sed 's/\o14//g' >> "$folder"/"$File".txt
echo -e "\n[*] $urltitle" >> "$foldermonth"/"$calendarfile"
if [[ ! $additiontext == "" ]]
then
	echo -e "$additiontext" >> "$foldermonth"/"$calendarfile"
fi
echo -e "$url" >> "$foldermonth"/"$calendarfile"
echo -e "[[+$File]]" >> "$foldermonth"/"$calendarfile"
echo -e "{{$File}}" >> "$foldermonth"/"$calendarfile"
fi
