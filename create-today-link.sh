	#!/bin/bash
	folder=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d")
	foldermonth=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/")
	filetxt=$(basename folder)
	#calendarfile=$(date +"%d")
	#calendarfile=$calendarfile.txt
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
	sed "/###/d" ~/Gedankenspeicher/Gedankenspeicherwiki/Zim-Arbeitsflaeche/Arbeitsflaeche.txt > ~/Gedankenspeicher/Gedankenspeicherwiki/Zim-Arbeitsflaeche/Arbeitsflaeche.txt.tmp
	mv ~/Gedankenspeicher/Gedankenspeicherwiki/Zim-Arbeitsflaeche/Arbeitsflaeche.txt.tmp ~/Gedankenspeicher/Gedankenspeicherwiki/Zim-Arbeitsflaeche/Arbeitsflaeche.txt
	sed -i "17 i### $(date +"[[Zettelkasten:%Y:%m:%d|Heute]]")" ~/Gedankenspeicher/Gedankenspeicherwiki/Zim-Arbeitsflaeche/Arbeitsflaeche.txt
	sed -i "18 i### $(date -d "yesterday" +"[[Zettelkasten:%Y:%m:%d|Gestern]]")" ~/Gedankenspeicher/Gedankenspeicherwiki/Zim-Arbeitsflaeche/Arbeitsflaeche.txt
	#ln -f "$folder".txt ~/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Gedankenwanderung/Zim-Arbeitsflaeche/Heute.txt
