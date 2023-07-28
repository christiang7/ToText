#!/bin/bash
file=$(readlink -f -n "$1")
filepath=$(echo "${file%/*}" | sed "s,/home/christian,~,")
wikipath=$(echo $filepath | sed "s,~/Gedankenspeicher/Gedankenspeicherwiki/,," | sed "s,/,:,g")
FullFilename=$(basename $file .md)
outputText="[[$filepath/$FullFilename]]\n[[$wikipath:$FullFilename]]"
echo -e $outputText
echo -e "[[$filepath/$FullFilename]]\n[[$wikipath:$FullFilename]]" | xclip -selection primary
echo -e "[[$filepath/$FullFilename]]\n[[$wikipath:$FullFilename]]" | xclip -selection clipboard
wlexecution=$(echo -e $outputText | wl-copy -n &)
sleep 1
killall wl-copy
exit
  #echo [[$wikipath:$FullFilename]] | xclip -selection primary
  #echo [[$wikipath:$FullFilename]] | xclip -selection clipboard
