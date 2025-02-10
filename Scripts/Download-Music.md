# Download-Music
Created Dienstag [Zettelkasten:2022:10:18]()

- [X] **Download-Music**

For dumping the website, but it is not good formated
```bash
lynx --dump  https://kalax.bandcamp.com/track/confie-hold-on-feat-francci

links2 -dump https://kalax.bandcamp.com/track/confie-hold-on-feat-francci
```


*run-cell.sh*
```bash
noweb.py -RDownload-Music.sh Download-Music.md > Download-Music.sh && echo "Download-Music.sh" && date
```

*Download-Music.sh*
```bash
#!/bin/bash
source config.sh; # load the config library functions
echo "$1"
website="$1"
musicDir="$(config_get musicDir)"
yt="$(echo "$website" | grep youtube)"
cd $musicDir
if [[ ! "$yt" = "" ]];
then
    text="$(yt-dlp --get-description ${website})"
    text="$(echo -e "${text}" | sed 's/\"//g')"
    yt-dlp --no-mtime --exec "tt {} \"${website}\" \"@Lied\" \"${text}\" " -o "$musicDir/%(title)s.%(ext)s" -f '251/140' -i "${website}"
else
    text=$(links2 -dump ${website})
    text="$(echo -e "${text}" | sed 's/\"//g')"
    yt-dlp --no-mtime --exec "tt {} \"${website}\" \"@Lied\" \"${text}\" " -o "$musicDir/%(title)s.%(ext)s" --embed-thumbnail -f b --no-mtime --audio-quality 0 -i "${website}"
fi
#sleep 5
```

