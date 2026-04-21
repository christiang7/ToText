# copy-file.sh
Created 2026-02-16


## Description

## Journal
 - [X] Backlog
    - [ ] 
 - [X] Doing
 
## bash code


*make.sh*
```bash
noweb.py -Rcopy-file.sh copy-file.sh.md > copy-file.sh && echo 'copy-file.sh' && notify-send -a "Compilation of copy-file.sh" "" "$(date +"%Y-%m-%d") fertig" 
```


```bash
chmod u+x copy-file.sh && ln -sf $(pwd)/copy-file.sh ~/.local/bin/copy-file.sh && echo 'fertig'
```

*copy-file.sh*
```bash
#!/bin/bash
source tt-lib.sh;
abfrage=$(yad --title="Copy-File" --text="Add headline?" \
    --form --separator="~" --item-separator="," \
    --field="- Insert Headline":CHK \
    "TRUE")
headline=$(echo "$abfrage" | cut -s -d "~" -f 1)
File=$(basename "$1" .md)
extens=${File##*.}
Filename=${File%.*}
#Filename=$(cleanName $Filename)
if [[ $headline == TRUE ]];
then
   #echo -e "==== $(date +"%Y-%m-%d")" > COPY
   echo -e "### $(date +"%Y-%m-%d")" > COPY
fi
if [[ jpg == $extens || PNG == $extens || JPEG == $extens || png == $extens || webp == $extens || jpeg == $extens || avif == $extens ]]
then
    #echo -e "{{./${File}?width=500}}">> COPY
    echo -e "![](./${File}){width=500px}">> COPY
fi
echo -e "[[+${File}]]" >> COPY
wl-copy "$(cat COPY)"
rm COPY
notify-send -a "File copied" "" "$(date +"%Y-%m-%d") fertig"
```
