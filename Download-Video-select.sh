#! /bin/bash
echo "$1"
website="$1"
#yt-dlp --no-mtime --fixup force -f "[height<=740]" --exec "ttdown {} ${website}" -o '~/Gedankenspeicher/Output/%(title)s.%(ext)s' -i "${website}"
yt-dlp --no-mtime --fixup force -f "[height<=740]/bv+ba" --exec "ttdown {} ${website}" -o '~/Gedankenspeicher/Output/%(title)s.%(ext)s' -i "${website}"
#sleep 50
# yt-dlp --no-mtime --exec 'ttdown {} '[HREF]' [SELECTIONTEXT]' -o '~/Gedankenspeicher/Arbeitsflaeche/Archiv-Verschiebung/%(title)s.%(ext)s' "[HREF]"
