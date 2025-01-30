# mpvv
Created Samstag [[Zettelkasten:2021:04:24]]
[*] **@ArcPROGRAMM @VIDEO mpvv**

Hiermit kann man mittels mpv und youtube-dl Videos abspielen und im Terminal die Video Beschreibung anzeigen lassen.

*run-cell.sh*
```bash
noweb.py -Rmpvv mpvv.md > mpvv && echo 'mpvv' && date
```


hier das Programm

*mpvv*
```bash
#!/bin/bash
echo "$1"
website="$1"
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
	file=$(yt-dlp --print filename -s -i "${website}" -o '%(title)s.%(ext)s')
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
# --restrict-filenames

file=$(echo "$ofile" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g'|  sed 's/&/n/g' | sed 's/\///g' | sed 's/|//g' | sed 's/\[/(/g' | sed 's/\]/)/g' | sed 's/@/at/g' | sed 's/｜/-/g' | sed 's/：/;/g')

#*temp-video-description}}

#DRI_PRIME=pci-0000_01_00_0 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia mpv --profile="$profile" "$website"
echo "file:///home/christian/Gedankenspeicher/Alte-Inputs/$file".md
mpv --profile="$profile" --screenshot-template="Screenshot-$file-%P" "$website"


```


*temp-video-description*
```bash
f=$file
extens=${f##*.}
name=$(basename "$f" .$extens)
folder=$(echo ~/Gedankenspeicher/Alte-Inputs/)
source=$website
File=$(echo "$name"."$extens" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g'|  sed 's/&/n/g' | sed 's/\///g' | sed 's/|//g' | sed 's/\[/(/g' | sed 's/\]/)/g' | sed 's/@/at/g' | sed 's/｜/-/g' | sed 's/：/;/g')

if [ ! -f "$folder""$File.md" ]
then
	additiontext="$(yt-dlp --get-description ${source})"
	if [[ ! $twitch == "" ]]
	then
		yt-dlp --sub-langs "en,de" --write-sub --write-auto-sub --sub-format "vtt" --skip-download -i ${source} -o "~/Gedankenspeicher/Alte-Inputs/%(title)s.%(ext)s"
		filename=$(basename "$File" .$extens)
		name=$(basename "$ofile" .$extens)
		mv "$folder$name".en.vtt "$folder""$filename".en.vtt
		mv "$folder$name.de.vtt" "$folder""$filename".de.vtt
		mv "$folder$name.en.srt" "$folder""$filename".en.srt
		mv "$folder$name.de.srt" "$folder""$filename".de.srt
	fi

	f=$(basename "$File")

	touch "$folder""$File".md
	echo "Content-Type: text/x-zim-wiki" >> "$folder""$File".md
	echo "Wiki-Format: zim 0.6" >> "$folder""$File".md
	echo "====== $f ======" >> "$folder""$File".md
	echo "Text date:$(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]") Modi date:$(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")" >> "$folder""$File".md
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
