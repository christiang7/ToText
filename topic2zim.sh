#! /bin/bash

choose=$(zenity --height 350 --list --radiolist --print-column ALL --hide-header --column "Checkbox" --column "What" TRUE Neu FALSE Video FALSE Musik FALSE Spiele FALSE Lesen FALSE Physik FALSE Mathematik FALSE Philosophie FALSE Software)
if [ ! $? -eq 1 ];
then
tabs="$(xclip -selection clipboard -o)"
l="" # lineposition of the desired file
case ${choose} in
Neu)

abfrage=$(yad --title="Neues Thema" --text="Noch etwas hinzufügen?" \
 	 --form --width 500 --separator="|" --item-separator=","  \
 	 --field="Name:" \
 	 --field="Quelle:":CBE \
 	 --field="Tags" \
 	 --field="Weiteres":TXT \
 	 "" "Internet,Christian Gößl" "" "")
if [ ! $? -eq 1 ];
then
  topic=$(echo $abfrage | cut -s -d "|" -f 1)
  source=$(echo $abfrage | cut -s -d "|" -f 2)
	tags=$(echo $abfrage | cut -s -d "|" -f 3)
	additiontext=$(echo $abfrage | cut -s -d "|" -f 4)

if [[ ! "$topic" = "" ]];
then

foldermonth=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten")
topicfile=$(echo "${topic}" | sed 's/ /_/g' | sed 's/:/;/g' | sed -e "s/'/_/g" | sed 's/\"//g'|  sed 's/&/n/g' | sed 's/|//g' | sed 's/\[/(/g' | sed 's/\]/)/g' | sed 's/@/at/g' | sed 's/¦//g' | sed 's/?/.ß/g').txt
topicfilename=$(basename "$topicfile" .txt)
touch "${foldermonth}"/"${topicfile}"
mkdir -p "${foldermonth}"/"${topicfilename}"
echo "Content-Type: text/x-zim-wiki" > "${foldermonth}"/"${topicfile}"
echo "Wiki-Format: zim 0.6" >> "${foldermonth}"/"${topicfile}"
echo -e "=====  ${topic} =====" >> "${foldermonth}"/"${topicfile}"
echo -e "Created $(date +[[Zettelkasten:%Y:%m:%d]])" >> "${foldermonth}"/"${topicfile}"
echo -e "Backlink [[Zettelkasten:ZetteL:Gedanken]]" >> "${foldermonth}"/"${topicfile}"
echo -e "[[../]]" >> "${foldermonth}"/"${topicfile}"
echo -e "[*] ${tags} ** ${topic} ** >  2277-11-11" >> "${foldermonth}"/"${topicfile}"
echo -e "\n${additiontext}" >> "${foldermonth}"/"${topicfile}"
echo -e "\n${tabs}" >> "${foldermonth}"/"${topicfile}"
echo -e "\n[[+$(basename ${topicfile} .txt)|${topic}]]" >> "$foldermonth".txt

fi
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
Video) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Video_Stream.txt")
	l=10;;
Musik) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/MusikStream.txt")
	l=7;;
Spiele) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/SpielE.txt")
	l=7;;
Lesen) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Buecher/Lesestoff.txt")
	l=7;;
Physik) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Physik.txt")
	l=10;;
Mathematik) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Mathematik.txt")
	l=10;;
Philosophie) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Philosophie.txt")
	l=10;;
Software) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/Software.txt")
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
