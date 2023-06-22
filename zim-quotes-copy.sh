#!/bin/bash
file=$(readlink -f -n "$1")
text=$(echo "$2")
filepath=$(echo "${file%/*}" | sed "s,/home/christian,~,")
wikipath=$(echo $filepath | sed "s,~/Gedankenspeicher/Gedankenspeicherwiki/,," | sed "s,/,:,g")
FullFilename=$(basename $file .md)
PageName=$(echo "$FullFilename" | sed 's/_/ /g')
dateID=$(date +"date%Y%m%d%H%M%S")
outputText="== [[$wikipath:$FullFilename\#$dateID|Zitat der Seite: $PageName]] ==\n ''$text''\n Vom $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")"
echo -n -e "**__ $text (Zitat {{id: $dateID}})__**"
wlexecution=$(echo -e $outputText | wl-copy -n &)
killall wl-copy
exit

