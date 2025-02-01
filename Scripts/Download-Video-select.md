# Download-Video-select
Created Dienstag [Zettelkasten:2022:10:18]()
- [X] **Download-Video-select**



*run-cell.sh*
```bash
noweb.py -RDownload-Video-select.sh Download-Video-select.md > Download-Video-select.sh && echo "Download-Video-select.sh" && date
```

```bash
chmod u+x Download-Video-select.sh && ln -sf /home/christian/Gedankenspeicher/KanDo/GedankenspeicherCoding/Download-Video-select.sh ~/.local/bin/Download-Video-select.sh && echo 'fertig'
```

for restricting the filename for the downloads in ``yt-dlp``
``--restrict-filenames``

*Download-Video-select.sh*
```bash
#! /bin/bash
source config.sh # load the config library functions
outputDir="$(config_get outputDir)"
source tt-lib.sh

echo "$1"
website="$1"
#yt-dlp --no-mtime --fixup force -f "[height<=740]" --exec "ttdown {} ${website}" -o '$outputDir/%(title)s.%(ext)s' -i "${website}"
yt-dlp --no-mtime --write-thumbnail --fixup force -f "311+234/232+234/612+234/[height<780]+ba" --add-chapters --sub-langs "en,de" --write-sub --write-auto-sub --sub-format "vtt" --external-downloader aria2c --http-chunk-size 5M --downloader-args aria2c:"-c -j 2 -s 2 -x 4 -k 50M" --exec "echo {}" -o "$outputDir/%(title)s.%(ext)s" -i "${website}"
#sleep 50
# yt-dlp --no-mtime --exec 'ttdown {} '[HREF]' [SELECTIONTEXT]' -o "$outputDir/%(title)s.%(ext)s" "[HREF]"

#*create note file}}

```


*create note file*
```bash
f=$(yt-dlp -f "311+234/232+234/612+234/[height<780]+ba" --print filename -s "${website}" -o '%(title)s.%(ext)s')
extens=${f##*.}
name=$(basename "$f" .$extens)
source=$(echo "$website")
folder=$outputDir/
journalPage="$(config_get journalPage)"
additiontext="$(yt-dlp --get-description ${source})"

abfrage=$(yad --title="Diese Datei eine TXT hinzufügen" --text="Noch etwas hinzufügen?" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Anderer Name:" \
	--field="Quelle:":CBE \
	--field="Tags" \
	--field="Weiteres":TXT \
	"$name" "$source,Internet,Christian Gößl" "$tags" "$additiontext")
if [ ! $? -eq 1 ];
then
	Newname=$(echo $abfrage | cut -s -d "~" -f 1)
	source=$(echo $abfrage | cut -s -d "~" -f 2)
	tags=$(echo $abfrage | cut -s -d "~" -f 3)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 4)
	File=$(cleanName "$Newname"."$extens")
	mv "$folder""$Newname"."$extens" "$folder""$File"

	filename=$(basename "$File" .$extens)

	mv "$folder$name.en.vtt" "$folder""$filename".en.vtt
	mv "$folder$name.de.vtt" "$folder""$filename".de.vtt
	mv "$folder$name.en.srt" "$folder""$filename".en.srt
	mv "$folder$name.de.srt" "$folder""$filename".de.srt

	convert "$folder$name.webp" "$folder""$File".avif
	rm "$folder$name.webp"

	f=$(basename "$File")

	touch "$folder""$File".md
	Wikiprev "$folder" "$File"
	Timestamps "$folder" "$File"

	echo "[*] @VIDEO $tags **[[../$f]]** $source" >> "$folder""$File".md
	echo "{{../$f.avif?width=500}}" >> "$folder""$File".md
	echo -e "\n$additiontext\n" >> "$folder""$File".md

	echo -e "\n*$filename.en.vtt*" >> "$folder""$File".md
	echo -e "\`\`\`bash" >> "$folder""$File".md
	cat "$folder""$filename".en.vtt >> "$folder""$File".md
	echo -e "\`\`\`" >> "$folder""$File".md

	echo -e "\n*$filename.de.vtt*" >> "$folder""$File".md
	echo -e "\`\`\`bash" >> "$folder""$File".md
	cat "$folder""$filename".de.vtt >> "$folder""$File".md
	echo -e "\`\`\`" >> "$folder""$File".md

	echo -e "\n*run-cell.sh*" >> "$folder""$File".md
	echo -e "\`\`\`bash" >> "$folder""$File".md
	echo -e "noweb.py -R$filename.de.vtt $File.md > $filename.de.vtt \nnoweb.py -R$filename.en.vtt $File.md > $filename.en.vtt \n echo '$File' && date \n\`\`\`\n\n" >> "$folder""$File".md
fi

```


