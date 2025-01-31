#!/bin/bash
echo "$1"
website="$1"
yt="$(echo "$website" | grep youtube)"
if [[ ! "$yt" = "" ]];
then
    text="$(yt-dlp --get-description ${website})"
    text="$(echo -e "${text}" | sed 's/\"//g')"
    yt-dlp --no-mtime --exec "tt {} \"${website}\" \"@Lied\" \"${text} \" " -o "~/Musik/Favorieten-open/%(title)s.%(ext)s" -f '251/140' -i "${website}"
else
    text=$(links2 -dump ${website})
    text="$(echo -e "${text}" | sed 's/\"//g')"
    yt-dlp --no-mtime --exec "tt {} \"${website}\" \"@Lied\" \"${text} \" " -o "~/Musik/Favorieten-open/%(title)s.%(ext)s" --embed-thumbnail -f b --no-mtime --audio-quality 0 -i "${website}"
fi
#sleep 5
