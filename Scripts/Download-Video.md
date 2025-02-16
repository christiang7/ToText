# Download-Video
Created Dienstag [Zettelkasten:2022:10:18]()
- [X] **Download-Video**



## informations

for restricting the filename for the downloads in ``yt-dlp``
``--restrict-filenames``

```bash
yt-dlp --no-mtime --fixup force -f "[height<=740]" --exec "ttdown {} ${website}" -o '$outputDir/%(title)s.%(ext)s' -i "${website}"

#sleep 50
yt-dlp --no-mtime --exec 'ttdown {} '[HREF]' [SELECTIONTEXT]' -o "$outputDir/%(title)s.%(ext)s" "[HREF]"
```

## main program

*run-cell.sh*
```bash
noweb.py -RDownload-Video.sh Download-Video.md > Download-Video.sh && echo "Download-Video.sh" && date
```

```bash
chmod u+x Download-Video.sh && ln -sf $(pwd)/Download-Video.sh ~/.local/bin/Download-Video.sh && echo 'fertig'
```


*Download-Video.sh*
```bash
#! /bin/bash
source config.sh # load the config library functions
source tt-lib.sh

outputDir="$(config_get outputDir)"
website="$1"
echo "$website"

yt="$(echo "$website" | grep youtube)"
twitch="$(echo "$website" | grep twitch)"
alttwitch="$(echo "$website" | grep safetwitch)"
invidious="$(echo "$website" | grep invidious)"
aeon="$(echo "$website" | grep aeon)"
vimeo="$(echo "$website" | grep vimeo)"
if [[ ! $yt == "" ]];
then
	format="311+234/232+234/612+234/[height<780][ext=mp4]+ba"
elif [[ ! $alttwitch == "" ]];
then
	videoid=$(basename $website)
	website="https://www.twitch.tv/videos/${videoid}"
	format="720p30/720p60/720p50/720/720p/720p-0/720p-1/1080p/1080/best/[ext=mp4]"
elif [[ ! $twitch == "" ]];
then
	format="720p30/720p60/720p50/720/720p/720p-0/720p-1/1080p/1080/best[ext=mp4]"
elif [[ ! $invidious == "" ]];
then
	videoid=$(basename $website)
	website="https://www.youtube/com/${videoid}"
	format="311+234/232+234/612+234/[height<780][ext=mp4]+ba"
elif [[ ! $aeon == "" || ! "$vimeo" = "" ]];
then
	format="best[height<=800][ext=mp4]"
else
	format="best[height<=800]/bv*[height<=780][ext=mp4]+ba"
fi
echo $format

yt-dlp --no-mtime --write-thumbnail --fixup force -f "$format" --add-chapters --sub-langs "en,de" --write-sub --write-auto-sub --sub-format "vtt" --external-downloader aria2c --http-chunk-size 5M --downloader-args aria2c:"-c -j 2 -s 2 -x 4 -k 50M" -o "$outputDir/%(title)s.%(ext)s" -i "${website}"

#*create note file}}

```


*create note file*
```bash
ofile=$(yt-dlp -f "[ext=mp4]" --print filename -s "${website}" -o '%(title)s.%(ext)s')
extens=${ofile##*.}
name=${ofile%.*}
additiontext="$(yt-dlp --get-description ${website})"

abfrage=$(yad --title="Create text file" --text="Something to add?" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Anderer Name:" \
	--field="Quelle:":CBE \
	--field="Tags" \
	--field="Weiteres":TXT \
	"$name" "$website,Internet,Christian Gößl" "$tags" "$additiontext")
if [ ! $? -eq 1 ];
then
	Newname=$(echo $abfrage | cut -s -d "~" -f 1)
	source=$(echo $abfrage | cut -s -d "~" -f 2)
	tags=$(echo $abfrage | cut -s -d "~" -f 3)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 4)

	File=$(cleanName "$Newname"."$extens")

	mv "$outputDir"/"$ofile" "$outputDir"/"$File"

	ttvid "$outputDir" "$File" "$tags" "$source" "$additiontext" "$ofile" "yes" "yes" >> "$outputDir"/"$File".md
fi

```


