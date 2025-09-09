# mpvv
Created Samstag 2021-04-24

Playing videos from websites with used tools mpv and yt-dlp

*make.sh*
```bash
noweb.py -Rmpvv mpvv.md > mpvv && echo 'mpvv' && date
```



### mpvv

*mpvv*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
tempInputDir="$(config_get tempInputDir)"
source tt-lib.sh;

website="$1"
noPlayback="$2"
yt="$(echo "$website" | grep youtube)"
twitch="$(echo "$website" | grep twitch)"
alttwitch="$(echo "$website" | grep safetwitch)"
invidious="$(echo "$website" | grep invidious)"
aeon="$(echo "$website" | grep aeon)"
vimeo="$(echo "$website" | grep vimeo)"
if [[ ! $yt == "" ]];
then
	#links2 -dump "$website" &
	profile="youtube"
	yt-dlp --get-description ${website}
	#website="https://iv.melmac.space/watch?v="
elif [[ ! $alttwitch == "" ]];
then
	videoid=$(basename $website)
	website="https://www.twitch.tv/videos/${videoid}"
	#links2 -dump ${website} &
	profile="twitch"
elif [[ ! $twitch == "" ]];
then
	#links2 -dump ${website} &
	profile="twitch"
elif [[ ! $invidious == "" ]];
then
	#links2 -dump ${website} &
	profile="invidious"
elif [[ ! $aeon == "" || ! "$vimeo" = "" ]];
then
	#links2 -dump ${website} &
	profile="normal"
else
	#links2 -dump ${website} &
	profile="normal"
fi
links2 -dump "$website" &

#DRI_PRIME=pci-0000_01_00_0 __VK_LAYER_NV_optimus=NVIDIA_only__ GLX_VENDOR_LIBRARY_NAME=nvidia mpv --profile="$profile" "$website"
#DRI_PRIME=pci-0000_01_00_0 __VK_LAYER_NV_optimus=NVIDIA_only__ GLX_VENDOR_LIBRARY_NAME=nvidia mpv --profile="$profile" --screenshot-template="Screenshot-$File-%P" "$website"
echo "$website"
if [[ $noPlayback == "" ]]
then
	#if [[ ! $yt == "" ]];
	#then
		#timeout 7s mpv --profile="$profile" --ytdl-format="bv*[height<=800][protocol^=m3u8][vcodec~='^((he|a)vc|h26[45])']+ba[protocol^=m3u8]/b[height<=790][protocol^=m3u8][vcodec~='^((he|a)vc|h26[45])']" --mute=yes --screenshot-template="Screenshot-$File-%P" "$website"
	#	timeout 7s mpv --profile="$profile" --ytdl-format="bv*[height<=800][vcodec~='^((he|a)vc|h26[45])'][resolution=1280x720]+ba[ext=m4a]/b[height<=790][vcodec~='^((he|a)vc|h26[45])']" --mute=yes --screenshot-template="Screenshot-$File-%P" "$website"
		# --save-position-on-quit=no
	#fi
	# --profile="$profile" 
	if [[ $profile == "normal" ]];
	then
		mpv --profile="$profile" --screenshot-template="Screenshot-$File-%P" "$website"
	else
		mpv --profile="$profile" --screenshot-template="Screenshot-$File-%P" --ytdl-format="bv*[height<=790][ext=mp4]+ba/b[height<=790][vcodec~='^((he|a)vc|h26[45])']" "$website"
	fi
	### mpv --profile="$profile" --screenshot-template="Screenshot-$File-%P" --ytdl-format="bv*[height<=800][vcodec~='^((he|a)vc|h26[45])'][resolution=1280x720]+ba[ext=m4a]/b[height<=790][vcodec~='^((he|a)vc|h26[45])']" "$website"
	#mpv --screenshot-template="Screenshot-$File-%P" --ytdl-format="bv*[height<=800][protocol^=m3u8][vcodec~='^((he|a)vc|h26[45])']+ba[protocol^=m3u8]/b[height<=790][protocol^=m3u8][vcodec~='^((he|a)vc|h26[45])']" "$website"
else
	kate "$tempInputDir/$File".md
fi
ofile=$(yt-dlp --print filename -s "${website}" -o '%(title)s').mp4
#ofile=${ofile%.*}.mp4
if [[ $ofile == "" ]]
then
	ofile=$(basename "${website}").mp4
fi
echo $profile

File=$(cleanName "$ofile")

#*temp-video-description}}

echo -e "\nfile://$tempInputDir/$File".md

```


### temp-video-description
*temp-video-description*
```bash

name=${File%.*}
extens=${File##*.}

if [[ ! -f "$tempInputDir"/"$File.md" ]]
then
	ttvid "$tempInputDir" "$File" "$tags" "$website" "$additiontext" "$ofile" "yes" "yes" >> "$tempInputDir"/"$File".md
fi
```
