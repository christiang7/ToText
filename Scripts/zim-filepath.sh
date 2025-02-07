#!/bin/bash
source config.sh; # load the config library functions
homeDir="$(config_get homeDir)"
wikiDir="$(config_get wikiDir)"

file=$(readlink -f -n "$1")
filepath=$(echo "${file%/*}" | sed "s,$homeDir,~,")
wikipath=$(echo $filepath | sed "s,$wikiDir,," | sed "s,/,:,g")
FullFilename=$(basename $file .md)
outputText="[[$filepath/$FullFilename]]\n[[$wikipath:$FullFilename]]"
#echo -e $outputText
echo -e "[[$filepath/$FullFilename]]\n[[$wikipath:$FullFilename]]" | xclip -selection primary
echo -e "[[$filepath/$FullFilename]]\n[[$wikipath:$FullFilename]]" | xclip -selection clipboard
wlexecution=$(echo -e $outputText | wl-copy -n &)
sleep 1
killall wl-copy
exit
  #echo [[$wikipath:$FullFilename]] | xclip -selection primary
  #echo [[$wikipath:$FullFilename]] | xclip -selection clipboard
