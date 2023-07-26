# syncthing-ttdm
Created Mittwoch [Zettelkasten:2022:10:12]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **syncthing-ttdm**


```bash
noweb.py -Rsyncthing-ttdm.sh syncthing-ttdm.md > syncthing-ttdm.sh && echo 'fertig'
```
```bash
chmod u+x syncthing-ttdm.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/ZetteL/CodeFabrik/syncthing-ttdm.sh ~/.local/bin/syncthing-ttdm.sh && echo 'fertig'
```
```bash
{{syncthing-ttdm.sh}}=
#!/bin/bash
FolderSync=$(echo "$1")
#ls --hide=*.md "$folder" > f
list=$(find "$FolderSync" -mtime +2)
# > f
#echo $list
#echo "$FolderSync"/

lines="$(wc --lines <<< "$list")"
for (( i=$lines ; i>=2 ; i-- )); 
do
	f=$(sed -n "${i}p" <(echo "$list"))
	echo "$f"

	#for f in $list;
	#do   
	#while read f
	#do
	#echo $f
	folder=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d" -r "$f")
	mkdir -p "$folder"
	g=$(basename "$f")
	File=$(echo "$g" | sed 's/ /_/g' | sed 's/:/;/g' | sed -e "s/'/_/g" | sed 's/\"//g' | sed 's/&/n/g' | sed 's/\///g' | sed 's/|//g' | sed 's/\[/(/g' | sed 's/\]/)/g')

	File=$(echo $FolderSync/"$File")
	#f=$(basename "$1")
	#File=$(basename "$File")
	Filename=$(basename "$File")
	#mv $folder-sync/"$g" "$File"
	extens=${File##*.}
	source="Telefon"
	tags=""
	additiontext="Vom Telefon importierte Datei"

	function Moving(){
		mv "$File" "$folder"/"$Filename"
		#mv "$File".md "$folder"/"$File".md
		echo "cd $folder"
		#kate $folder/"$File".md 2>/dev/null &
	}

	function Wikiprev(){
		touch "$folder"/"$File".md
		echo "Content-Type: text/x-zim-wiki" >> $folder/"$Filename".md
		echo "Wiki-Format: zim 0.6" >> $folder/"$Filename".md
		echo "===== $Filename =====" >> $folder/"$Filename".md
	}

	function Timestamps(){
		echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" >> $folder/"$Filename".md
		echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$File")" >> $folder/"$Filename".md
	}

	foldermonth=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m" -r "$File")
	calendarfile=$(date +"%d" -r "$File")
	calendarfile=$calendarfile.md
	if [[ ! -e "$foldermonth"/"$calendarfile" ]] 
		then
		touch "$foldermonth"/"$calendarfile"
		echo "Content-Type: text/x-zim-wiki" >> "$foldermonth"/"$calendarfile"
		echo "Wiki-Format: zim 0.6" >> "$foldermonth"/"$calendarfile"
		date +"===== %A %d %b %Y =====" -r "$File" >> "$foldermonth"/"$calendarfile"
		#date +"[[Zettelkasten:%Y:Week %W|Week %W]]" -r "$File" >> "$foldermonth"/"$calendarfile"
		date +"[[Zettelkasten:%Y:%m]]" -r "$File" >> "$foldermonth"/"$calendarfile"
		echo -e ""  >> "$foldermonth"/"$calendarfile"
		date +"[*] ** %A %d %b %Y ** "  -r "$File" >> "$foldermonth"/"$calendarfile"
	fi


	#if [[ -f "$File".md ]] 
	#then
	#		Moving
	#else
	if [[ pdf == $extens ]]
		then
		#echo pdf
		#ttpdfm "$f" "$source" "$tags" "$additiontext"
		###
		if [[ ! -e "$Filename".md ]] 
		then
			touch "$folder"/"$Filename".md
			echo "Content-Type: text/x-zim-wiki" >> "$folder"/"$Filename".md
			echo "Wiki-Format: zim 0.6" >> "$folder"/"$Filename".md
			echo "===== $Filename =====" >> $folder/"$Filename".md
			echo "[*] @ARTIKEL $tags **[[../$Filename]] $source**" >> "$folder"/"$Filename".md
			echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" >> "$folder"/"$Filename".md
			echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$File")" >> "$folder"/"$Filename".md
			echo -e "\n" >> "$folder"/"$Filename".md
			echo -e "$additiontext\n" >> "$folder"/"$Filename".md
			echo -e "{{../$Filename.png?width=500}}\n" >> "$folder"/"$Filename".md
			pdfinfo "$File" | grep Pages >> "$folder"/"$Filename".md
			pdftotext -nopgbrk -enc UTF-8 -f 1 -l 1 "$File" ->> "$folder"/"$Filename".md
		else
			mv "$File".md "$folder"/"$Filename".md
			sed -i "9 i$additiontext" "$folder"/"$Filename".md
			echo -e "\n" >> "$folder"/"$Filename".md
			sed -i "13 i{{../$Filename.png?width=500}}" "$folder"/"$Filename".md
			echo -e "\n" >> "$folder"/"$Filename".md
		fi
		pdftoppm -r 90 -png -singlefile "$File" "$folder"/"$Filename"
		echo -e "\n[[./$Filename]] [[+$Filename]]" >> "$foldermonth"/"$calendarfile"
		echo -e "{{$Filename.png?width=500}}" >> "$foldermonth"/"$calendarfile"
		echo "cd $folder"
		mv "$File" $folder/"$Filename"
	elif [[ jpg == $extens || png == $extens || webp == $extens || jpeg == $extens || avif == $extens || svg == $extens ]] 
	then
		#echo pic
		if [[ ! -e "$Filename".md ]] 
		then
			touch "$folder"/"$Filename".md
			echo "Content-Type: text/x-zim-wiki" >> "$folder"/"$Filename".md
			echo "Wiki-Format: zim 0.6" >> "$folder"/"$Filename".md
			echo "===== $Filename =====" >> $folder/"$Filename".md
			echo "[*] @BILD $tags **[[../$Filename]] $source**" >> "$folder"/"$Filename".md
			echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" >> "$folder"/"$Filename".md
			echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$File")" >> "$folder"/"$Filename".md
			echo -e "\n$additiontext" >> "$folder"/"$Filename".md
			echo "{{../$Filename?width=500}}" >> "$folder"/"$Filename".md
		else
			mv "$File".md "$folder"/"$Filename".md
			echo "$additiontext" >> "$folder"/"$Filename".md
		fi
		echo -e "\n[[+$Filename]]" >> "$foldermonth"/"$calendarfile"
		echo -e "{{$Filename?width=500}}" >> "$foldermonth"/"$calendarfile"
		mv "$File" $folder/"$Filename"
	elif [[ mp4 == $extens || mov == $extens || mkv == $extens || flv = $extens ]] 
	then
		folder=~/Gedankenspeicher/Arbeitsflaeche/Archiv-Verschiebung/
		if [[ ! -e "$File".md ]] 
		then
			touch "$folder"/"$Filename".md
			echo "Content-Type: text/x-zim-wiki" >> "$folder"/"$Filename".md
			echo "Wiki-Format: zim 0.6" >> "$folder"/"$Filename".md
			echo "===== $Filename =====" >> $folder/"$Filename".md
			echo "[*] @VIDEO $tags **[[../$Filename]] $source**" >> "$folder"/"$Filename".md
			echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" >> "$folder"/"$Filename".md
			echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$File")" >> "$folder"/"$Filename".md
			echo -e "\n" >> "$folder"/"$Filename".md
			echo -e "$additiontext\n" >> "$folder"/"$Filename".md
			echo -e "{{../$Filename.png?width=500}}\n" >> "$folder"/"$Filename".md
			ffmpeg -loglevel quiet -ss 2 -i "$File"  -t 1 -f image2 "$folder"/"$Filename".png
		else
			mv "$File".md "$folder"/"$Filename".md
			sed -i "9 i$additiontext" "$folder"/"$Filename".md
			#echo -e "\n" >> "$folder"/"$File".md
			#sed -i "13 i{{../$File.png?width=500}}" "$folder"/"$File".md
			#echo -e "\n" >> "$folder"/"$File".md
			mv "$File".png "$folder"/"$Filename".png
		fi
		mv "$File" $folder/"$Filename"
	elif [[ epub == $extens ]] 
	then
		Wikiprev
		echo "[*] @EBOOK $tags **[[../$Filename]] $source**" >> "$folder"/"$Filename".md
		Timestamps
		echo -e "\n$additiontext\n" >> "$folder"/"$Filename".md
		einfo "$File" >> "$folder"/"$Filename".md
		Moving
	elif [[ $extens == $g ]] 
	then
		Wikiprev
		echo "[*] @ORDNER $tags **[[../$Filename]] $source**" >> "$folder"/"$Filename".md
		Timestamps
		echo -e "\n$additiontext\n" >> "$folder"/"$Filename".md
		Moving
	else
		Wikiprev
		echo "[*] $tags **[[../$Filename]] $source**" >> "$folder"/"$Filename".md
		Timestamps
		echo -e "\n$additiontext\n" >> "$folder"/"$Filename".md
		Moving
	fi

	#done < f
done

#rm f
@
```

