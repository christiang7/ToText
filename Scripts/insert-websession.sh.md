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

{{{code: lang="sh" linenumbers="True"

*insert-websession.sh*
```bash
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
```
}}}
