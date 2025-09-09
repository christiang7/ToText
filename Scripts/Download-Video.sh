#! /bin/bash
source config.sh # load the config library functions
source tt-lib.sh

outputDir="$(config_get outputDir)"
website="$1"
echo "$website"

yt="$(echo "$website" | grep youtu)"
twitch="$(echo "$website" | grep twitch)"
alttwitch="$(echo "$website" | grep safetwitch)"
invidious="$(echo "$website" | grep invidious)"
aeon="$(echo "$website" | grep aeon)"
vimeo="$(echo "$website" | grep vimeo)"
if [[ ! $yt == "" ]];
then
	format="bv*[height<=790][ext=mp4]+ba/b[height<=790][vcodec~='^((he|a)vc|h26[45])']"
	#format="bv*[height<=800][vcodec~='^((he|a)vc|h26[45])'][resolution=1280x720]+ba[ext=m4a]/b[height<=800][vcodec~='^((he|a)vc|h26[45])']"
	#[vcodec~='^((he|a)vc|h26[45])']
	#format="(bv*+ba/b)[protocol^=m3u8][protocol!*=http][height<780][vcodec=av01]"
	#format="bestvideo[protocol=m3u8]+bestaudio[protocol=m3u8]/best[protocol=m3u8]/311+234/232+234/612+234/bv*[height<780][ext=mp4]+ba"
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

yt-dlp --no-mtime --fixup force -f "$format" --merge-output mp4 --add-chapters --external-downloader aria2c --http-chunk-size 256k --downloader-args aria2c:"-c -j 8 -s 8 -x 8 -k 1M" -o "$outputDir/%(title)s.%(ext)s" -i "${website}"

ofile=$(yt-dlp --print filename -s "${website}" -o '%(title)s').mp4
extens=${ofile##*.}
name=${ofile%.*}
additiontext="$(yt-dlp --get-description ${website})"
author="$(config_get author)"

abfrage=$(yad --title="Create text file" --text="Something to add?" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Anderer Name:" \
	--field="Quelle:":CBE \
	--field="Tags" \
	--field="Weiteres":TXT \
	"$name" "$website,Internet,$author" "$tags" "$additiontext")
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


notify-send -a "Video Download finished" "Video $File" "$(cat ~/.config/tt/log)"

