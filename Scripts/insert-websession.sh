#!/bin/bash
source tt-lib.sh
journalPage="$(config_get journalPage)"

File=$1
filetxt=${File%.*}
File=$(cleanName "$1")

sessionfile=$(yad --title="Insert websession?" --text="\nSave copied tabs\n" \
	--form --width 500 --separator="" --item-separator=","  \
	--field="Filename:" \
	"2»websession_$(date +"%Y-%m-%d-%H-%M-%S")")
if [ ! $? -eq 1 ];
then
   sessionfile=$(cleanName "$sessionfile")
   mkdir -p "$filetxt"
   echo "===== $sessionfile =====" >> "$filetxt"/"$sessionfile".md
   echo "$(wl-paste -n)" >> "$filetxt"/"$sessionfile".md
   #echo -e "==== $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]") "
   echo -e "==== $(date +"%Y-%m-%d") "
   echo "[[+$sessionfile]]"
   #notify-send -a "insert-websession finished" "$filename" "$(cat ~/.config/tt/log)"
fi
