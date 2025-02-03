#! /bin/bash
source config.sh # load the config library functions
source tt-lib.sh

outputDir="$(config_get outputDir)"
website="$1"
echo "$website"

yt-dlp --no-mtime --write-thumbnail --fixup force -f "311+234/232+234/612+234/[height<780]+ba" --add-chapters --sub-langs "en,de" --write-sub --write-auto-sub --sub-format "vtt" --external-downloader aria2c --http-chunk-size 5M --downloader-args aria2c:"-c -j 2 -s 2 -x 4 -k 50M" -o "$outputDir/%(title)s.%(ext)s" -i "${website}"

ofile=$(yt-dlp -f "311+234/232+234/612+234/[height<780]+ba" --print filename -s "${website}" -o '%(title)s.%(ext)s')
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

	ttvid "$outputDir" "$File" "$tags" "$source" "$additiontext" "$ofile" "yes" "yes"
fi


