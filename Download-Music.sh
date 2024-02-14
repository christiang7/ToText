#!/bin/bash
echo "$1"
website="$1"
text=$(links2 -dump ${website})
text="$(echo -e "${text}" | sed 's/\"//g')"
yt-dlp --no-mtime --exec "ttn {} \"${website}\" \"@Lied\" \"${text} \" " -o "~/Musik/Favorieten-open/%(title)s.%(ext)s" --embed-thumbnail -f b --no-mtime --audio-quality 0 -i "${website}"
sleep 5
