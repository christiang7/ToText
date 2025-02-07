# create-today-link
Created Dienstag [Zettelkasten:2022:06:28]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **create-today-link**


Erzeugung eines Ordners der immer auf den aktuellen Ordner vom Zim Journal zeigt

Beispiel
``ln -ds  ~/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/2022/06/25 ~/Heute``

*run-cell.sh*
```bash
noweb.py -Rcreate-today-link.sh create-today-link.md > create-today-link.sh && echo 'fertig'
```



*create-today-link.sh*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
journalDir="$(config_get journalDir)"
wikiDir="$(config_get wikiDir)"

folder=$(date +"$journalDir/%Y/%m/%d")
foldermonth=$(date +"$journalDir/%Y/%m/")
filetxt=$(basename folder)
#calendarfile=$(date +"%d")
#calendarfile=$calendarfile.md
#if [[ ! -e "$foldermonth"/"$calendarfile" ]]
#then
	#touch "$foldermonth"/"$calendarfile"
	#echo "Content-Type: text/x-zim-wiki" >> "$foldermonth"/"$calendarfile"
	#echo "Wiki-Format: zim 0.6" >> "$foldermonth"/"$calendarfile"
	#date +"===== %A %d %b %Y =====" >> "$foldermonth"/"$calendarfile"
	#date +"[[$journalPage:%Y:%W|Week %W]]" >> "$foldermonth"/"$calendarfile"
	#date +"[[$journalPage:%Y:%m]]" >> "$foldermonth"/"$calendarfile"
	#echo -e ""  >> "$foldermonth"/"$calendarfile"
	#date +"[*] ** %A %d %b %Y ** " >> "$foldermonth"/"$calendarfile"
#fi
mkdir -p $folder
echo $folder
rm -r ~/Heute
ln -fs "$folder" ~/Heute
sed "/###/d" $wikiDir/Zim-Arbeitsflaeche/Arbeitsflaeche.md > $wikiDir/Zim-Arbeitsflaeche/Arbeitsflaeche.md.tmp
mv $wikiDir/Zim-Arbeitsflaeche/Arbeitsflaeche.md.tmp $wikiDir/Zim-Arbeitsflaeche/Arbeitsflaeche.md
sed -i "17 i### $(date +"[[$journalPage:%Y:%m:%d|Heute]]")" $wikiDir/Zim-Arbeitsflaeche/Arbeitsflaeche.md
sed -i "18 i### $(date -d "yesterday" +"[[$journalPage:%Y:%m:%d|Gestern]]")" $wikiDir/Zim-Arbeitsflaeche/Arbeitsflaeche.md
#ln -f "$folder".md $journalDir/Gedankenwanderung/Zim-Arbeitsflaeche/Heute.md
```

