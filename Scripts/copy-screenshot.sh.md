===== copy-screenshot.sh =====
# copy-screenshot.sh
Created 2026-02-16


## Description

## Journal
 - [X] Backlog
    - [ ] 
 - [X] Doing
 
## bash code


*make.sh*
```bash
noweb.py -Rcopy-screenshot.sh copy-screenshot.sh.md > copy-screenshot.sh && echo 'copy-screenshot.sh' && notify-send -a "Compilation of copy-screenshot.sh" "" "$(date +"%Y-%m-%d") fertig" 
```


```bash
chmod u+x copy-screenshot.sh && ln -sf $(pwd)/copy-screenshot.sh ~/.local/bin/copy-screenshot.sh && echo 'fertig'
```

*copy-screenshot.sh*
```bash
#!/bin/bash
source config.sh; # load the config library functions
source tt-lib.sh;
abfrage=$(yad --title="Inset-Screenshot" --text="Add headline?" \
    --form --separator="~" --item-separator="," \
    --field="Insert Headline:":CB \
    "Yes,No")
headline=$(echo "$abfrage" | cut -s -d "~" -f 1)
Filename=$(basename "$1")
#Filename=$(cleanName $Filename)
if [[ $headline == "Yes" ]];
then
   echo -e "==== $(date +"%Y-%m-%d")" > COPY
fi

echo -e "{{./${Filename}?width=500}}" >> COPY
echo -e "[[+${Filename}]]" >> COPY
wl-copy "$(cat COPY)"
rm COPY
```
