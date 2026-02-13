# Download-Music
Created Dienstag [2022:10:18]()

- [X] **Download-Music**

For dumping the website, but it is not good formated
```bash
lynx --dump  https://kalax.bandcamp.com/track/confie-hold-on-feat-francci

links2 -dump https://kalax.bandcamp.com/track/confie-hold-on-feat-francci
```


*make.sh*
```bash
noweb.py -RDownload-Music.sh Download-Music.sh.md > Download-Music.sh && echo "Download-Music.sh" && date && notify-send -a "Compilation of Download-Music.sh" "" "$(date +"%Y-%m-%d") fertig"
```

### Download-Music.sh
*Download-Music.sh*
```bash
#!/bin/bash
source config.sh; # load the config library functions
source tt-lib.sh
echo "$1"
website="$1"
musicDir="$(config_get musicDir)"
yt="$(echo "$website" | grep youtube)"
#cd $musicDir
if [[ ! "$yt" = "" ]];
then
    text="$(yt-dlp --get-description ${website})"
    #text="$(echo -e "${text}" | sed 's/\"//g')"
    yt-dlp --no-mtime -o "$musicDir/%(title)s.%(ext)s" -f "140/251" --js-runtimes deno:/home/christian/.deno/bin/deno --remote-components ejs:github -i "${website}"
	ofile=$(yt-dlp --print filename -s "${website}" -f "140/251" --js-runtimes deno:/home/christian/.deno/bin/deno --remote-components ejs:github -o "%(title)s.%(ext)s")
else
    text=$(links2 -dump ${website})
    #text=$(echo -e "${text}")
    yt-dlp --no-mtime -o "$musicDir/%(title)s.%(ext)s" --js-runtimes deno:/home/christian/.deno/bin/deno --remote-components ejs:github --embed-thumbnail -f b --no-mtime --audio-quality 0 -i "${website}"
	ofile=$(yt-dlp --print filename -s "${website}" -f b --audio-quality 0 --js-runtimes deno:/home/christian/.deno/bin/deno --remote-components ejs:github -o "%(title)s.%(ext)s")
fi

extens=${ofile##*.}
name=${ofile%.*}
#additiontext="$(yt-dlp --get-description ${website})"
author="$(config_get author)"

abfrage=$(yad --title="Create text file" --text="Something to add?" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Anderer Name:" \
	--field="Quelle:":CBE \
	--field="Tags" \
	--field="Weiteres":TXT \
	"$name" "$website,Internet,$author" "$tags" "$text")
if [ ! $? -eq 1 ];
then
	Newname=$(echo $abfrage | cut -s -d "~" -f 1)
	source=$(echo $abfrage | cut -s -d "~" -f 2)
	tags=$(echo $abfrage | cut -s -d "~" -f 3)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 4)

	File=$(cleanName "$Newname"."$extens")

	mv "$musicDir"/"$ofile" "$musicDir"/"$File"
    
    file-description "$musicDir" "$File" "@Musik $tags" "$source" "$text" >> "$musicDir"/"$File".md
fi

notify-send -a "Music Download finished" "Music $File" ""
#sleep 5
```

