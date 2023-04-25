# ttdm
Created Donnerstag [Zettelkasten:2022:10:13]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **ttdm**  >  2277-11-11


  ``noweb.py -Rttdm ttdm.md > ttdm && chmod u+x ttdm && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Gedankenwanderung/Programme/ttdm ~/.local/bin/ttdm && echo 'fertig'``

```bash
{{ttdm}}=
#!/bin/bash
FolderSync=$(echo "$1" | sed 's/\///g')
#ls --hide=*.txt "$folder" > f
list=$(find "$FolderSync"/)
# > f
#echo $list
#echo "$FolderSync"/
for f in $list;
do   
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
source=""
tags=""
additiontext=""

function Moving(){
	mv "$File" "$folder"/"$Filename"
	#mv "$File".txt "$folder"/"$File".txt
	echo "cd $folder"
	#kate $folder/"$File".txt 2>/dev/null &
}

function Wikiprev(){
	touch "$folder"/"$File".txt
	echo "Content-Type: text/x-zim-wiki" >> $folder/"$Filename".txt
	echo "Wiki-Format: zim 0.6" >> $folder/"$Filename".txt
}

function Timestamps(){
	echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" >> $folder/"$Filename".txt
	echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$File")" >> $folder/"$Filename".txt
}

foldermonth=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m" -r "$File")
calendarfile=$(date +"%d" -r "$File")
calendarfile=$calendarfile.txt
if [[ ! -e "$foldermonth"/"$calendarfile" ]] 
	then
	touch "$foldermonth"/"$calendarfile"
	echo "Content-Type: text/x-zim-wiki" >> "$foldermonth"/"$calendarfile"
	echo "Wiki-Format: zim 0.6" >> "$foldermonth"/"$calendarfile"
	date +"===== %A %d %b %Y =====" -r "$File" >> "$foldermonth"/"$calendarfile"
	date +"[[Zettelkasten:%Y:%W|Week %W]]" -r "$File" >> "$foldermonth"/"$calendarfile"
	date +"[[Zettelkasten:%Y:%m]]" -r "$File" >> "$foldermonth"/"$calendarfile"
	echo -e "[[../]]"  >> "$foldermonth"/"$calendarfile"
	date +"[*] ** %A %d %b %Y ** >  2277-11-11"  -r "$File" >> "$foldermonth"/"$calendarfile"
fi


#if [[ -f "$File".txt ]] 
#then
#		Moving
#else
if [[ pdf == $extens ]]
	then
	#echo pdf
	#ttpdfm "$f" "$source" "$tags" "$additiontext"
	####
	if [[ ! -e "$Filename".txt ]] 
	then
	touch "$folder"/"$Filename".txt
	echo "Content-Type: text/x-zim-wiki" >> "$folder"/"$Filename".txt
	echo "Wiki-Format: zim 0.6" >> "$folder"/"$Filename".txt
	echo "[*] @ARTIKEL $tags **[[../$Filename]] $source**" >> "$folder"/"$Filename".txt
	echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" >> "$folder"/"$Filename".txt
	echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$File")" >> "$folder"/"$Filename".txt
	echo -e "[[../]]\n" >> "$folder"/"$Filename".txt
	echo -e "$additiontext\n" >> "$folder"/"$Filename".txt
	echo -e "{{../$Filename.png?width=750}}\n" >> "$folder"/"$Filename".txt
	pdfinfo "$File" | grep Pages >> "$folder"/"$Filename".txt
	pdftotext -nopgbrk -enc UTF-8 -f 1 -l 1 "$File" ->> "$folder"/"$Filename".txt
	else
	mv "$File".txt "$folder"/"$Filename".txt
	sed -i "9 i$additiontext" "$folder"/"$Filename".txt
	echo -e "\n" >> "$folder"/"$Filename".txt
	sed -i "13 i{{../$Filename.png?width=750}}" "$folder"/"$Filename".txt
	echo -e "\n" >> "$folder"/"$Filename".txt
	fi
	pdftoppm -r 90 -png -singlefile "$File" "$folder"/"$Filename"
	echo -e "\n[[./$Filename]] [[+$Filename]]" >> "$foldermonth"/"$calendarfile"
	echo -e "{{$Filename.png?width=750}}" >> "$foldermonth"/"$calendarfile"
	echo "cd $folder"
	mv "$File" $folder/"$Filename"
elif [[ jpg == $extens || png == $extens || webp == $extens || jpeg == $extens || avif == $extens || svg == $extens ]] 
then
	#echo pic
	if [[ ! -e "$Filename".txt ]] 
	then
	touch "$folder"/"$Filename".txt
	echo "Content-Type: text/x-zim-wiki" >> "$folder"/"$Filename".txt
	echo "Wiki-Format: zim 0.6" >> "$folder"/"$Filename".txt
	echo "[*] @BILD $tags **[[../$Filename]] $source**" >> "$folder"/"$Filename".txt
	echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" >> "$folder"/"$Filename".txt
	echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$File")" >> "$folder"/"$Filename".txt
	echo -e "[[../]]\n$additiontext" >> "$folder"/"$Filename".txt
	echo "{{../$Filename?width=750}}" >> "$folder"/"$Filename".txt
	else
	mv "$File".txt "$folder"/"$Filename".txt
	echo "$additiontext" >> "$folder"/"$Filename".txt
	fi
	echo -e "\n[[+$Filename]]" >> "$foldermonth"/"$calendarfile"
	echo -e "{{$Filename?width=750}}" >> "$foldermonth"/"$calendarfile"
	mv "$File" $folder/"$Filename"
elif [[ mp4 == $extens || mov == $extens || mkv == $extens || flv = $extens ]] 
then
	folder=~/Gedankenspeicher/Arbeitsflaeche/Archiv-Verschiebung/
	if [[ ! -e "$File".txt ]] 
	then
	touch "$folder"/"$Filename".txt
	echo "Content-Type: text/x-zim-wiki" >> "$folder"/"$Filename".txt
	echo "Wiki-Format: zim 0.6" >> "$folder"/"$Filename".txt
	echo "[*] @VIDEO $tags **[[../$Filename]] $source**" >> "$folder"/"$Filename".txt
	echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" >> "$folder"/"$Filename".txt
	echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$File")" >> "$folder"/"$Filename".txt
	echo -e "[[../]]\n" >> "$folder"/"$Filename".txt
	echo -e "$additiontext\n" >> "$folder"/"$Filename".txt
	echo -e "{{../$Filename.png?width=750}}\n" >> "$folder"/"$Filename".txt
	ffmpeg -loglevel quiet -ss 2 -i "$File"  -t 1 -f image2 "$folder"/"$Filename".png
	else
	mv "$File".txt "$folder"/"$Filename".txt
	sed -i "9 i$additiontext" "$folder"/"$Filename".txt
	#echo -e "\n" >> "$folder"/"$File".txt
	#sed -i "13 i{{../$File.png?width=750}}" "$folder"/"$File".txt
	#echo -e "\n" >> "$folder"/"$File".txt
	mv "$File".png "$folder"/"$Filename".png
	fi
	mv "$File" $folder/"$Filename"
elif [[ epub == $extens ]] 
then
		Wikiprev
		echo "[*] @EBOOK $tags **[[../$Filename]] $source**" >> "$folder"/"$Filename".txt
		Timestamps
		echo -e "[[../]]\n$additiontext\n" >> "$folder"/"$Filename".txt
		einfo "$File" >> "$Filename".txt
		Moving
elif [[ $extens == $g ]] 
then
	Wikiprev
	echo "[*] @ORDNER $tags **[[../$Filename]] $source**" >> "$folder"/"$Filename".txt
	Timestamps
	echo -e "[[../]]\n$additiontext\n" >> "$folder"/"$Filename".txt
	Moving
else
	Wikiprev
	echo "[*] $tags **[[../$Filename]] $source**" >> "$folder"/"$Filename".txt
	Timestamps
	#echo -e "$2\n" >> "$File".txt
	echo -e "[[../]]\n$additiontext\n" >> "$Filename".txt
	Moving
fi

#done < f
done

#rm f
@
```

