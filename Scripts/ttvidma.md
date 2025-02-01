# ttvidma
Created Montag [Zettelkasten:2022:03:07]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **ttvidma**

*run-cell.sh*
```bash
noweb.py -Rttvidma ttvidma.md > ttvidma && chmod u+x ttvidma && echo 'fertig'
```

*ttvidma*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
journalDir="$(config_get journalDir)"
archiveDir="$(config_get archiveDir)"
GedankenspeicherwikiDir="$(config_get GedankenspeicherwikiDir)"

File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
#f=$(basename "$1")
mv "$1" "$File"
f=$(basename "$File")
filename=${f%.*} #only the filename
folder=$(date +"$journalDir/%Y/%m/%d" -r "$f")
archivfolder="$archiveDir/Videos"
mkdir -p $folder
if [[ -e "$filename".md && ! -d "$filename" ]];
	then
	ttvidc "$f"
fi
if [[ -f "$File".md ]]
then
	sed -i "3 i**Ins Archiv2 verschoben und verlinkt**" "$File".md
else
	touch "$File".md
	echo "Content-Type: text/x-zim-wiki" >> "$File".md
	echo "Wiki-Format: zim 0.6" >> "$File".md
	echo "[*] @ARCHIV2 @VIDEO **[[../$f]] $2**" >> "$File".md
	echo "Text creation time: $(date +"[[$journalPage:%Y:%m:%d]]")" >> "$File".md
	echo "Modification time: $(date +"[[$journalPage:%Y:%m:%d]]" -r "$f")" >> "$File".md
	echo -e "$2\nIns Archiv2 verschoben und verlinkt" >> "$File".md
	ffmpeg -loglevel quiet -ss 2 -i "$File"  -t 1 -f image2 "$File".png
	convert "$File".png -resize 1200x1200 -quality 97 "$File"-px.png
mv "$File"-px.png "$File".png
echo "{{../$File.png?width=500}}" >> "$File".md
fi
videostream=$(echo "$GedankenspeicherwikiDir/Video_Stream.md")
sed -i "10i
" "$videostream"
sed -i "10 s,^,[[$(date +"$journalPage:%Y:%m:%d" -r "$f"):$File]]," "$videostream"
sed -i "10i
" "$videostream"
sed -i "10 s,^,[[$archivfolder/"$File"]]," "$videostream"
sed -i "10i
" "$videostream"
mv "$f" $archivfolder/"$f"
mv "$File".md $folder/"$File".md
cp "$File".png $folder/"$File".png
mv "$File".png $archivfolder/"$File".png
ln -s $archivfolder/"$f" $folder/"$f"
ln -s $folder/"$File".md $archivfolder/"$File".md
echo "cd $folder"
zenity --info --text="Verschiebung fertig"
#kate $folder/"$File".md 2>/dev/null &
```



