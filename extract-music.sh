#! /bin/bash
echo "$1"
website="$1"
text=$(yt-dlp --get-description ${website})
echo 'yt-dlp --no-mtime --exec "ttn {} '${website}' '@Lied' '${text}'" -o "~/Musik/Favorieten-open/%(title)s.%(ext)s" -f 251 -i "${website}"'
yt-dlp --no-mtime --exec "ttn {} '${website}' '@Lied' '${text}'" -o "~/Musik/Favorieten-open/%(title)s.%(ext)s" -f 251 -i "${website}"
sleep 5
# xterm -e "echo [HREF] && yt-dlp --no-mtime --exec 'ttn {} [HREF]' -o '~/Musik/Favorieten-open/%(title)s.%(ext)s' -f 251 -i [HREF] && sleep 5"
