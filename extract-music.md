# extract-music
Created Dienstag [Zettelkasten:2022:10:18]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **extract-music**  >  2277-11-11


  ``noweb.py -Rextract-music.sh extract-music.md > extract-music.sh && echo 'fertig'``

``chmod u+x extract-music.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Gedankenwanderung/Programme/extract-music.sh ~/.local/bin/extract-music.sh && echo 'fertig'``


```bash
<<extract-music.sh>>=
#! /bin/bash
echo "$1"
website="$1"
text=$(yt-dlp --get-description ${website})
yt-dlp --no-mtime --exec "ttn {} \"${website}\" \"@Lied\" \"${text}\"" -o "~/Musik/Favorieten-open/%(title)s.%(ext)s" -f 251 -i "${website}"
sleep 5
@
```

