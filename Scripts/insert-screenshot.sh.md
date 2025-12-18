===== insert-screenshot.sh =====
# insert-screenshot.sh
Created 2025-12-02


## Description

## Journal
 - [x] Backlog
    - [ ] 
 - [x] Doing
 
## sh code


*make.sh*
```bash
noweb.py -Rinsert-screenshot.sh insert-screenshot.sh.md > insert-screenshot.sh && echo 'insert-screenshot.sh' && notify-send -a "Compilation" "" "$(date +"%Y-%m-%d") fertig" 
chmod u+x insert-screenshot.sh && ln -sf $(pwd)/insert-screenshot.sh ~/.local/bin/insert-screenshot.sh && echo 'fertig'
```


```bash
```

*insert-screenshot.sh*
```bash
#!/bin/bash
source config.sh; # load the config library functions
source tt-lib.sh;
abfrage=$(yad --title="Inset-Screenshot" --text="Add headline?" \
    --form --separator="~" --item-separator="," \
    --field="Insert Headline:":CB \
    "Yes,No")
headline=$(echo "$abfrage" | cut -s -d "~" -f 1)
Filename="$(basename -z $(wl-paste -n))"
#Filename=$(cleanName $Filename)
if [[ $headline == "Yes" ]];
then
   echo -e "==== $(date +"%Y-%m-%d") "
fi

echo -e "{{./${Filename}?width=500}} "
echo -e "[[+${Filename}]] "

```


