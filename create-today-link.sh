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
	#echo -e "[[../]]"  >> "$foldermonth"/"$calendarfile"
	#date +"[*] ** %A %d %b %Y ** >  2277-11-11" >> "$foldermonth"/"$calendarfile"
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
