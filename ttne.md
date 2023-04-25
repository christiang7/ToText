# ttne
Created Dienstag [Zettelkasten:2022:11:01]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **ttne**  >  2277-11-11


einen Zim Ordner mit txt Datei erstellen lassen irgendwo im Dateisystem

  ``noweb.py -Rttne.sh ttne.bash > ttne.sh && chmod u+x ttne.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/ZetteL/CadeFabrik/ttne.sh ~/.local/bin/ttne.sh && echo 'fertig'``

```bash
{{ttne.sh}}=
#!/usr/bin/env bash


if [[ ! -e "$1" ]] 
then
	folder=$(pwd)
	echo $folder
else
  folder=$(echo "$1")
  echo $folder
fi

Newname=$(zenity --entry \
       --width 500 \
       --title "Welchen Namen?" \
       --text "Welchen Namen?" \
       --entry-text "$filename")
if [ ! $? -eq 1 ]; 
then

File=$(echo "$Newname" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g'|  sed 's/&/n/g' | sed 's/\///g' | sed 's/|//g' | sed 's/\[/(/g' | sed 's/\]/)/g' | sed 's/@/at/g')

#extens=${f##*.}
#zimpath="${folder}"

source="Christian Gößl"
tags=$(echo "$3")
additiontext=$(echo "$4")

abfrage=$(zenity --forms \
       --width 500 \
       --title "Noch etwas hinzufügen?" \
       --text "Noch etwas hinzufügen?" \
       --add-entry "Quelle" --add-entry "Schlagwörter" --add-entry "Weiteres")
if [[ ! "$abfrage" = "" ]]; 
then
	source=$(echo $abfrage | cut -s -d "|" -f 1)
	tags=$(echo $abfrage | cut -s -d "|" -f 2)
	additiontext=$(echo $abfrage | cut -s -d "|" -f 3)
fi

mkdir -p "${folder}"/"${File}" 
echo "Content-Type: text/x-zim-wiki" > "${folder}"/"${File}".md
echo "Wiki-Format: zim 0.6" >> "${folder}"/"${File}".md
echo -e "===== ${File} =====" >> "${folder}"/"${File}".md
echo -e "Created $(date +"%A") $(date +[[Zettelkasten:%Y:%m:%d]])" >> "${folder}"/"${File}".md
#echo -e "Backlink $([[Zettelkasten:%Y:%m:%d]])" >> "${folder}"/"${File}".md
echo -e "[[../]]" >> "${folder}"/"${File}".md
echo -e "[*] ${tags} ** ${File} ** ${source} >  2277-11-11" >> "${folder}"/"${File}".md
echo -e "\n${additiontext}" >> "${folder}"/"${File}".md
#echo -e "\n${tabs}" >> "${folder}"/"${File}".md

fi
@ 
```

