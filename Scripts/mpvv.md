# mpvv
Created Samstag [[2021:04:24]]

Playing videos from websites with used tools mpv and yt-dlp

*run-cell.sh*
```bash
noweb.py -Rmpvv mpvv.md > mpvv && echo 'mpvv' && date
```


hier das Programm

*mpvv*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
tempInputDir="$(config_get tempInputDir)"
source tt-lib.sh;

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
	yt-dlp --get-description "$website" &
	ofile=$(yt-dlp -f "311+234/232+234/612+234/[height<780]+ba" --print filename -s -i "${website}" -o '%(title)s.%(ext)s')
	profile="youtube"
	#website="https://iv.melmac.space/watch?v="
elif [[ ! $alttwitch == "" ]];
then
	videoid=$(basename $website)
	website="https://www.twitch.tv/videos/${videoid}"
	links2 -dump ${website} &
	ofile=$(yt-dlp -f "720p30/720p60/720p50/720/720p/720p-0/720p-1/1080p/1080" --print filename -s -i "${website}" -o '%(title)s.%(ext)s')
	profile="twitch"
elif [[ ! $twitch == "" ]];
then
	links2 -dump ${website} &
	ofile=$(yt-dlp -f "720p30/720p60/720p50/720/720p/720p-0/720p-1/1080p/1080" --print filename -s -i "${website}" -o '%(title)s.%(ext)s')
	profile="twitch"
elif [[ ! $invidious == "" ]];
then
	links2 -dump ${website} &
	ofile=$(yt-dlp --print filename -s -i "${website}" -o '%(title)s.%(ext)s')
	profile="invidious"
elif [[ ! $aeon == "" || ! "$vimeo" = "" ]];
then
	links2 -dump ${website} &
	ofile=$(yt-dlp --print filename -s -i "${website}" -o '%(title)s.%(ext)s')
	profile="normal"
else
	links2 -dump ${website} &
	ofile=$(yt-dlp --print filename -s "${website}" -o '%(title)s.%(ext)s')
	profile="normal"
fi
echo $profile

File=$(cleanName "$ofile")

#*temp-video-description}}

#DRI_PRIME=pci-0000_01_00_0 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia mpv --profile="$profile" "$website"
echo -e "\nfile://$tempInputDir/$File".md
mpv --profile="$profile" --screenshot-template="Screenshot-$File-%P" "$website"


```


*temp-video-description*
```bash

name=${File%.*}
extens=${File##*.}

if [ ! -f "$folder"/"$File.md" ]
then
	ttvid "$tempInputDir" "$File" "$tags" "$website" "$additiontext" "$ofile" "yes" "yes"
fi
```
