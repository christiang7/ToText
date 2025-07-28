# insert-websession.sh
Created [2025-04-05]()


## Description

## Journal
 - [x] Backlog
	- [ ] 
 - [x] Doing
 
## sh code


*make.sh*
```bash
noweb.py -Rinsert-websession.sh insert-websession.sh.md > insert-websession.sh && echo 'insert-websession.sh' && date 
```


```bash
chmod u+x insert-websession.sh && ln -sf $(pwd)/insert-websession.sh ~/.local/bin/insert-websession.sh && echo 'fertig'
```


*insert-websession.sh*
```bash
#!/bin/bash
source tt-lib.sh
journalPage="$(config_get journalPage)"

File=$1
folder=${File%.*}
#File=$(cleanName "$1")

session=$(yad --title="Insert websession?" --text="\nSave copied tabs\n" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Filename:" \
	"2»ws_$(date +"%Y-%m-%d")")
if [ ! $? -eq 1 ];
then
   sessionfile=$(echo "$session" | cut -s -d "~" -f 1)

   sessionfile=$(cleanName "$sessionfile") 
   mkdir -p "$folder"
   if [[ ! -e "$folder"/"$sessionfile".md ]]
   then
      echo -e "==== $(date +"%Y-%m-%d") "
      echo "[[+$sessionfile]]"
      echo "====== $sessionfile ======" >> "$folder"/"$sessionfile".md
   fi
   echo "$(wl-paste -n)" >> "$folder"/"$sessionfile".md
   #echo -e "==== $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]") "
   #notify-send -a "insert-websession finished" "$filename" "$(cat ~/.config/tt/log)"
fi
```
