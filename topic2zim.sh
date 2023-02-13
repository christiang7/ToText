#! /bin/bash
#if zenity --question --text="Möchten Sie die Links speichern?"
#then


choose=$(zenity --height 350 --list --radiolist --print-column ALL --hide-header --column "Checkbox" --column "What" TRUE Neu FALSE Video FALSE Musik FALSE Spiele FALSE Lesen FALSE Physik FALSE Mathematik FALSE Philosophie FALSE Software)
if [ ! $? -eq 1 ];
then
tabs="$(xclip -selection clipboard -o)"
l="" # lineposition of the desired file
case ${choose} in
Neu)
abfrage=$(zenity --forms \
       --width 500 \
       --title "Noch etwas hinzufügen?" \
       --text "Noch etwas hinzufügen?" \
       --add-entry "Thema" --add-entry "Schlagwörter" --add-entry "Weiteres")

topic=$(echo $abfrage | cut -s -d "|" -f 1)
tags=$(echo $abfrage | cut -s -d "|" -f 2)
additiontext=$(echo $abfrage | cut -s -d "|" -f 3)

#topic=$(zenity --entry \
#       --width 500 \
#       --title "Was für ein Thema?" \
#       --text "Was für ein Thema?" \
#       --entry-text "$1")
#tags=$(zenity --entry \
#       --width 500 \
#       --title "Noch Schlagwörter hinzufügen?" \
#       --text "Noch Schlagwörter hinzufügen?" \
#       --entry-text "$2")
#additiontext=$(zenity --entry \
#       --width 500 \
#       --title "Noch etwas hinzufügen?" \
#       --text "Noch etwas hinzufügen?" \
#       --entry-text "$3")

if [[ ! "$topic" = "" && ! "$abfrage" = "" ]];
then

foldermonth=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m")
calendarday=$(date +"%d")
mkdir -p "${foldermonth}"/"$calendarday"
calendarfile=${calendarday}.txt
topicfile=$(echo "${topic}" | sed 's/ /_/g' | sed 's/:/;/g' | sed -e "s/'/_/g" | sed 's/\"//g'|  sed 's/&/n/g' | sed 's/|//g' | sed 's/\[/(/g' | sed 's/\]/)/g' | sed 's/@/at/g' | sed 's/¦//g' | sed 's/?/.ß/g').txt
echo "${topicfile}"
touch "${foldermonth}"/"$calendarday"/"${topicfile}"

if [[ ! -e "$foldermonth"/"$calendarfile" ]]
then
	touch "$foldermonth"/"$calendarfile"
	echo "Content-Type: text/x-zim-wiki" >> "$foldermonth"/"$calendarfile"
	echo "Wiki-Format: zim 0.6" >> "$foldermonth"/"$calendarfile"
	date +"===== %A %d %b %Y =====" >> "$foldermonth"/"$calendarfile"
	date +"[[Zettelkasten:%Y:Week %W|Week %W]]" >> "$foldermonth"/"$calendarfile"
	date +"[[Zettelkasten:%Y:%m]]"  >> "$foldermonth"/"$calendarfile"
	echo -e "[[../]]"  >> "$foldermonth"/"$calendarfile"
	date +"[*] ** %A %d %b %Y ** >  2277-11-11"  >> "$foldermonth"/"$calendarfile"
fi
echo "Content-Type: text/x-zim-wiki" > "${foldermonth}"/"$calendarday"/"${topicfile}"
echo "Wiki-Format: zim 0.6" >> "${foldermonth}"/"$calendarday"/"${topicfile}"
echo -e "=====  ${topic} =====" >> "${foldermonth}"/"$calendarday"/"${topicfile}"
echo -e "Created $(date +"%A") $(date +[[Zettelkasten:%Y:%m:%d]])" >> "${foldermonth}"/"$calendarday"/"${topicfile}"
echo -e "Backlink $(date +[[Zettelkasten:%Y:%m:%d]])" >> "${foldermonth}"/"$calendarday"/"${topicfile}"
echo -e "[[../]]" >> "${foldermonth}"/"$calendarday"/"${topicfile}"
echo -e "[*] ${tags} ** ${topic} ** >  2277-11-11" >> "${foldermonth}"/"$calendarday"/"${topicfile}"
echo -e "\n${additiontext}" >> "${foldermonth}"/"$calendarday"/"${topicfile}"
echo -e "\n${tabs}" >> "${foldermonth}"/"$calendarday"/"${topicfile}"
echo -e "\n[[+$(basename ${topicfile} .txt)|${topic}]]" >> "$foldermonth"/"$calendarfile"
fi;;

*)
additiontext=$(zenity --entry \
       --width 500 \
       --title "Noch etwas hinzufügen?" \
       --text "Noch etwas hinzufügen?" \
       --entry-text "")
if [ ! $? -eq 1 ];
then
case ${choose} in
Video) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Zim-Arbeitsflaeche/Video_Stream.txt")
	l=10;;
Musik) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Zim-Arbeitsflaeche/MusikStream.txt")
	l=7;;
Spiele) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/ZetteL/SpielE.txt")
	l=7;;
Lesen) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/ZetteL/Buecher/Lesestoff.txt")
	l=7;;
Physik) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Zim-Arbeitsflaeche/Physik.txt")
	l=10;;
Mathematik) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Zim-Arbeitsflaeche/Mathematik.txt")
	l=10;;
Philosophie) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Zim-Arbeitsflaeche/Philosophie.txt")
	l=10;;
Software) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/ZetteL/CodeFabrik/Software.txt")
	l=10;;
esac
echo $tabs
today=$(date +"[[Zettelkasten:%Y:%m:%d]]")
sed -i "${l}i
" "$file"
element=""
lines="$(wc --lines <<< "$tabs")"
for (( i=$lines ; i>=1 ; i-- ));
  do
	element=$(sed -n "${i}p" <(echo "$tabs"))
	echo "$element"
	if (($i % 2 != 0));
	then
	element=$(echo "${element}" | sed 's/\//-/g' | sed 's/:/;/g')
	echo "$element"
	fi
	#echo ${i}
	sed -i "${l} s,^,$element," "$file"
	if [[ $i > 1 ]]
	then
	  sed -i "${l}i
" "$file"
	fi
  done
sed -i "${l}i $additiontext" "$file"
sed -i "${l}i
" "$file"
sed -i "${l}s/^/$today/g" "$file"
sed -i "${l}i
" "$file"
fi;;
esac
fi
