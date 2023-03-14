#! /bin/bash
echo "$1"
website="$1"
text=$(yt-dlp --get-description ${website})
yt-dlp --no-mtime --exec "ttn {} \"${website}\" \"$text\"" -o "~/Musik/Favorieten-open/%(title)s.%(ext)s" --embed-thumbnail --format best --no-mtime --audio-quality 0 -i "${website}"
sleep 5
# xterm -e "yt-dlp --exec 'ttn {} [HREF] ' -o '~/Musik/Favorieten-open/%(title)s.%(ext)s' --embed-thumbnail --format best --no-mtime --audio-quality 0 -i [HREF]"
