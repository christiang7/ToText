#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
homeDir="$(config_get homeDir)"
GedankenspeicherwikiDir="$(config_get GedankenspeicherwikiDir)"

file=$(readlink -f -n "$1")
text=$(echo "$2")
filepath=$(echo "${file%/*}" | sed "s,$homeDir,~,")
wikipath=$(echo $filepath | sed "s,$GedankenspeicherwikiDir,," | sed "s,/,:,g")
FullFilename=$(basename $file .md)
PageName=$(echo "$FullFilename" | sed 's/_/ /g')
dateID=$(date +"date%Y%m%d%H%M%S")
outputText="== [[$wikipath:$FullFilename\#$dateID|Zitat der Seite: $PageName]] ==\n ''$text''\n Vom $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]")"
echo -n -e "**__ $text (Zitat {{id: $dateID}})__**"
wlexecution=$(echo -e $outputText | wl-copy -n &)
sleep 1
killall wl-copy
exit
