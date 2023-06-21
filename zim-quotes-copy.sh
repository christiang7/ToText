#!/bin/bash
file=$(readlink -f -n "$1")
text=$(echo "$2")
filepath=$(echo "${file%/*}" | sed "s,/home/christian,~,")
wikipath=$(echo $filepath | sed "s,~/Gedankenspeicher/Gedankenspeicherwiki/,," | sed "s,/,:,g")
FullFilename=$(basename $file .md)
PageName=$(echo "$FullFilename" | sed 's/_/ /g')
dateID=$(date +"date%Y%m%d%H%M%S")
outputText="== [[$wikipath:$FullFilename\#$dateID|Zitat der Seite: $PageName]] ==\n $text\n Vom $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")"
echo -n -e "$text {{id: $dateID}}"
#xclip -selection c "$(echo -e "== [[$wikipath:$FullFilename\#$dateID|Zitat der Seite: $PageName]] ==\n $text\n Vom $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")")"
#xclip -selection clipboard "$(echo -e "== [[$wikipath:$FullFilename\#$dateID|Zitat der Seite: $PageName]] ==\n $text\n Vom $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")")" &
#wl-copy --primary -n -f << '$(echo -e "== [[$wikipath:$FullFilename\#$dateID|Zitat der Seite: $PageName]] ==\n $text\n Vom $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")")'
#wl-copy -n < $outputText ;
wlexecution=$(echo -e $outputText | wl-copy -n &)
killall wl-copy
#echo -e $outputText | wl-copy -n ;
exit

