#! /bin/bash
echo "$1"
website="$1"
#yt-dlp --no-mtime --fixup force -f "[height<=740]" --exec "ttdown {} ${website}" -o '~/Gedankenspeicher/Output/%(title)s.%(ext)s' -i "${website}"
yt-dlp --no-mtime --write-thumbnail --fixup force -f "311+234/232+234/612+234/[height<780]+ba" --add-chapters --sub-langs "en,de" --write-sub --write-auto-sub --sub-format "vtt" --external-downloader aria2c --http-chunk-size 5M --downloader-args aria2c:"-c -j 2 -s 2 -x 4 -k 50M" --exec "echo {}" -o '~/Gedankenspeicher/Output/%(title)s.%(ext)s' -i "${website}"
#sleep 50
# yt-dlp --no-mtime --exec 'ttdown {} '[HREF]' [SELECTIONTEXT]' -o '~/Gedankenspeicher/Arbeitsflaeche/Archiv-Verschiebung/%(title)s.%(ext)s' "[HREF]"

f=$(yt-dlp -f "311+234/232+234/612+234/[height<780]+ba" --print filename -s "${website}" -o '%(title)s.%(ext)s')
extens=${f##*.}
name=$(basename "$f" .$extens)
source=$(echo "$website")
folder=$(echo ~/Gedankenspeicher/Output/)
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

	File=$(echo "$Newname"."$extens" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g'|  sed 's/&/n/g' | sed 's/\///g' | sed 's/|//g' | sed 's/\[/(/g' | sed 's/\]/)/g' | sed 's/@/at/g' | sed 's/｜/-/g' | sed 's/：/;/g')
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
	echo "Content-Type: text/x-zim-wiki" >> "$folder""$File".md
	echo "Wiki-Format: zim 0.6" >> "$folder""$File".md
	echo "====== $f ======" >> "$folder""$File".md
	echo "Text date:$(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]") Modi date:$(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]" -r "$folder""$File")" >> "$folder""$File".md
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


