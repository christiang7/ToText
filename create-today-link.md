# create-today-link
Created Dienstag [Zettelkasten:2022:06:28]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **create-today-link**


Erzeugung eines Ordners der immer auf den aktuellen Ordner vom Zim Journal zeigt

Beispiel
``ln -ds  ~/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/2022/06/25 ~/Heute``

  ``noweb.py -Rcreate-today-link.sh create-today-link.md > create-today-link.sh && echo 'fertig'``


``chmod u+x create-today-link.sh && ln -sf ~/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/GedakenspeicherCoding/create-today-link.sh ~/.local/bin/create-today-link.sh && echo 'fertig'``

```bash
{{create-today-link.sh}}=
	#!/bin/bash
	folder=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d")
	foldermonth=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/")
	filetxt=$(basename folder)
	#calendarfile=$(date +"%d")
	#calendarfile=$calendarfile.md
	#if [[ ! -e "$foldermonth"/"$calendarfile" ]] 
	#then
	#touch "$foldermonth"/"$calendarfile"
	#echo "Content-Type: text/x-zim-wiki" >> "$foldermonth"/"$calendarfile"
	#echo "Wiki-Format: zim 0.6" >> "$foldermonth"/"$calendarfile"
	#date +"===== %A %d %b %Y =====" >> "$foldermonth"/"$calendarfile"
	#date +"[[Zettelkasten:%Y:%W|Week %W]]" >> "$foldermonth"/"$calendarfile"
	#date +"[[Zettelkasten:%Y:%m]]" >> "$foldermonth"/"$calendarfile"
	#echo -e ""  >> "$foldermonth"/"$calendarfile"
	#date +"[*] ** %A %d %b %Y ** " >> "$foldermonth"/"$calendarfile"
	#fi
	mkdir -p $folder
	echo $folder
	rm -r /home/christian/Heute
	ln -fs "$folder" ~/Heute
	sed "/###/d" ~/Gedankenspeicher/Gedankenspeicherwiki/Zim-Arbeitsflaeche/Arbeitsflaeche.md > ~/Gedankenspeicher/Gedankenspeicherwiki/Zim-Arbeitsflaeche/Arbeitsflaeche.md.tmp
	mv ~/Gedankenspeicher/Gedankenspeicherwiki/Zim-Arbeitsflaeche/Arbeitsflaeche.md.tmp ~/Gedankenspeicher/Gedankenspeicherwiki/Zim-Arbeitsflaeche/Arbeitsflaeche.md
	sed -i "17 i### $(date +"[[Zettelkasten:%Y:%m:%d|Heute]]")" ~/Gedankenspeicher/Gedankenspeicherwiki/Zim-Arbeitsflaeche/Arbeitsflaeche.md
	sed -i "18 i### $(date -d "yesterday" +"[[Zettelkasten:%Y:%m:%d|Gestern]]")" ~/Gedankenspeicher/Gedankenspeicherwiki/Zim-Arbeitsflaeche/Arbeitsflaeche.md
	#ln -f "$folder".md ~/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Gedankenwanderung/Zim-Arbeitsflaeche/Heute.md
@
```

