# firefox-maff-export-txt
Created Freitag [Zettelkasten:2022:05:20]()

- [X] **firefox-maff-export-txt**

*run-cell.sh*
```bash
noweb.py -Rfirefox-maff-export-txt firefox-maff-export-txt.md > firefox-maff-export-txt && chmod u+x firefox-maff-export-txt && echo 'fertig'
```


*firefox-maff-export-txt*
```bash
#!/bin/sh
#for f in "$@"; do
#  u=$(printf "%s" "$f" | sed "s|%|%25|g" | sed "s|?|%3F|g" | sed "s|#|%23|g")
#  unzip -Z -1 "$f" '*/' | while read s; do
#    [ -z ${s#*/} ] && cat "${u}/${s}index.rdf"
#  done
#done

File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
folder=$(unzip -Z -1 "$1" '*/')
unzip "$1"
tt "$1" && cat $folder'index.rdf' >> "$File".md && rm -r $folder
```

