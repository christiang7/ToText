# save-websession.sh
Created [2025-02-17]()


## Description

## Journal
 - [X] Backlog
    - [ ] 
 - [X] Doing
 
## sh code


*run-cell.sh*
```bash
noweb.py -Rsave-websession.sh save-websession.sh.md > save-websession.sh && echo 'save-websession.sh' && date 
```


```bash
chmod u+x save-websession.sh && ln -sf $(pwd)/save-websession.sh ~/.local/bin/save-websession.sh && echo 'fertig'
```

*save-websession.sh*
```bash
#!/bin/bash
source tt-lib.sh
inputDir="$(config_get inputDir)"

filename=$(yad --title="Save websession?" --text="\nSave copied tabs\n" \
	--form --width 500 --separator="" --item-separator=","  \
	--field="Filename:" \
	"2»websession_$(date +"%Y-%m-%d-%H-%M-%S")")
if [ ! $? -eq 1 ];
then
   filename=$(cleanName "$filename")
   echo "$inputDir"/"$filename".md
   echo "$(wl-paste -n)" >> "$inputDir"/"$filename".md
fi
```
