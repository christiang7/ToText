# Download-Music
Created Dienstag [Zettelkasten:2022:10:18]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **Download-Music**  >  2277-11-11


  ``noweb.py -RDownload-Music.sh Download-Music.md > Download-Music.sh && echo 'fertig'``

``chmod u+x Download-Music.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Gedankenwanderung/Programme/Download-Music.sh ~/.local/bin/Download-Music.sh && echo 'fertig'``

```bash
<<Download-Music.sh>>=
#! /bin/bash
echo "$1"
website="$1"
text=$(yt-dlp --get-description ${website})
yt-dlp --no-mtime --exec "ttn {} \"${website}\" \"$text\"" -o "~/Musik/Favorieten-open/%(title)s.%(ext)s" --embed-thumbnail --format best --no-mtime --audio-quality 0 -i "${website}"
sleep 5
@
```

