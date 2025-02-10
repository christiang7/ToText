#!/bin/bash
source config.sh; # load the config library functions
echo "$1"
website="$1"
musicDir="$(config_get musicDir)"
yt="$(echo "$website" | grep youtube)"
cd $musicDir
if [[ ! "$yt" = "" ]];
then
    text="$(yt-dlp --get-description ${website})"
    text="$(echo -e "${text}" | sed 's/\"//g')"
    yt-dlp --no-mtime --exec "tt {} \"${website}\" \"@Lied\" \"${text}\" " -o "$musicDir/%(title)s.%(ext)s" -f '251/140' -i "${website}"
else
    text=$(links2 -dump ${website})
    text="$(echo -e "${text}" | sed 's/\"//g')"
    yt-dlp --no-mtime --exec "tt {} \"${website}\" \"@Lied\" \"${text}\" " -o "$musicDir/%(title)s.%(ext)s" --embed-thumbnail -f b --no-mtime --audio-quality 0 -i "${website}"
fi
#sleep 5
