# Download-Video-select
Created Dienstag [Zettelkasten:2022:10:18]()
- [X] **Download-Video-select**



```bash
{{run-cell.sh}}=
noweb.py -RDownload-Video-select.sh Download-Video-select.md > Download-Video-select.sh && echo 'fertig'
@
```

```bash
chmod u+x Download-Video-select.sh && ln -sf /home/christian/Gedankenspeicher/KanDo/GedankenspeicherCoding/Download-Video-select.sh ~/.local/bin/Download-Video-select.sh && echo 'fertig'
```

```bash
{{Download-Video-select.sh}}=
#! /bin/bash
echo "$1"
website="$1"
#yt-dlp --no-mtime --fixup force -f "[height<=740]" --exec "ttdown {} ${website}" -o '~/Gedankenspeicher/Output/%(title)s.%(ext)s' -i "${website}"
yt-dlp --no-mtime --fixup force -f "[height<=740]/bv+ba" --exec "ttdown {} ${website}" -o '~/Gedankenspeicher/Output/%(title)s.%(ext)s' -i "${website}"
#sleep 50
# yt-dlp --no-mtime --exec 'ttdown {} '[HREF]' [SELECTIONTEXT]' -o '~/Gedankenspeicher/Arbeitsflaeche/Archiv-Verschiebung/%(title)s.%(ext)s' "[HREF]"
@
```

