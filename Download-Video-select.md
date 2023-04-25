# Download-Video-select
Created Dienstag [Zettelkasten:2022:10:18]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **Download-Video-select**  >  2277-11-11


  ``noweb.py -RDownload-Video-select.sh Download-Video-select.md > Download-Video-select.sh && echo 'fertig'``

``chmod u+x Download-Video-select.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/GedankenspeicherCoding/Download-Video-select.sh ~/.local/bin/Download-Video-select.sh && echo 'fertig'``

```bash
<<Download-Video-select.sh>>=
#! /bin/bash
echo "$1"
website="$1"
yt-dlp --no-mtime --fixup force -f "[height<=740]" --exec "ttdown {} ${website} && sleep 5" -o '~/Gedankenspeicherwiki/Zim-Arbeitsflaeche/Archiv-Verschiebung/%(title)s.%(ext)s' -i "${website}"
sleep 50
# yt-dlp --no-mtime --exec 'ttdown {} '[HREF]' [SELECTIONTEXT]' -o '~/Gedankenspeicher/Arbeitsflaeche/Archiv-Verschiebung/%(title)s.%(ext)s' "[HREF]"
@
```

