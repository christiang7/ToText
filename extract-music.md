# extract-music
Created Dienstag [Zettelkasten:2022:10:18]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **extract-music**


```bash
noweb.py -Rextract-music.sh extract-music.md > extract-music.sh && echo 'fertig'
```

```bash
chmod u+x extract-music.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Gedankenwanderung/Programme/extract-music.sh ~/.local/bin/extract-music.sh && echo 'fertig'
```


```bash
{{extract-music.sh}}=
#! /bin/bash
echo "$1"
website="$1"
text="$(yt-dlp --get-description ${website})"
text="$(echo -e "${text}" | sed 's/\"//g')"
yt-dlp --no-mtime --exec "ttn {} \"${website}\" \"@Lied\" \"${text} \" " -o "~/Musik/Favorieten-open/%(title)s.%(ext)s" -f 251 -i "${website}"
sleep 5
@
```

