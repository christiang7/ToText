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

```bash
chmod u+x Download-Music.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Gedankenwanderung/Programme/Download-Music.sh ~/.local/bin/Download-Music.sh && echo 'fertig'
```

*Download-Music.sh*
```bash
#!/bin/bash
echo "$1"
website="$1"
yt="$(echo "$website" | grep youtube)"
if [[ ! "$yt" = "" ]];
then
    text="$(yt-dlp --get-description ${website})"
    text="$(echo -e "${text}" | sed 's/\"//g')"
    yt-dlp --no-mtime --exec "ttn {} \"${website}\" \"@Lied\" \"${text} \" " -o "~/Musik/Favorieten-open/%(title)s.%(ext)s" -f '251/140' -i "${website}"
else
    text=$(links2 -dump ${website})
    text="$(echo -e "${text}" | sed 's/\"//g')"
    yt-dlp --no-mtime --exec "ttn {} \"${website}\" \"@Lied\" \"${text} \" " -o "~/Musik/Favorieten-open/%(title)s.%(ext)s" --embed-thumbnail -f b --no-mtime --audio-quality 0 -i "${website}"
fi
#sleep 5
```

