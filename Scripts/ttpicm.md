# ttpicm

- [X] **ttpicm**

Angelegt Montag [Zettelkasten:2021:05:03]()

*run-cell.sh*
```bash
noweb.py -Rttpicm ttpicm.md > ttpicm && chmod u+x ttpicm && echo 'fertig'
```

*ttpicm*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
journalDir="$(config_get journalDir)"

File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
f=$(basename "$1")
folder=$(date +"$journalDir/%Y/%m/%d" -r "$1")
foldermonth=$(date +"$journalDir/%Y/%m" -r "$1")
mkdir -p $folder
calendarfile=$(date +"%d" -r "$f")
calendarfile=$calendarfile.md
if [[ ! -e "$foldermonth"/"$calendarfile" ]]
then
    touch "$foldermonth"/"$calendarfile"
    date +"===== %A %d %b %Y ====="  -r "$f">> "$foldermonth"/"$calendarfile"
    #date +"[[$journalPage:%Y:%W|Week %W]]"   -r "$f">> "$foldermonth"/"$calendarfile"
    date +"[[$journalPage:%Y:%m]]"  -r "$f">> "$foldermonth"/"$calendarfile"
    echo -e ""  >> "$foldermonth"/"$calendarfile"
    date +"[*] **%A %d %b %Y ** "  -r "$f" >> "$foldermonth"/"$calendarfile"
    #mv "$calendarfile" "$foldermonth"/"$calendarfile"
fi
touch "$File".md
echo "Content-Type: text/x-zim-wiki" >> "$File".md
echo "Wiki-Format: zim 0.6" >> "$File".md
echo "[*] @BILD $3 **[[../$f]] $2**" >> "$File".md
echo "Text creation time: $(date +"[[$journalPage:%Y:%m:%d]]")" >> "$File".md
echo "Modification time: $(date +"[[$journalPage:%Y:%m:%d]]" -r "$1")" >> "$File".md
echo -e "\n$4\n" >> "$File".md
echo "{{../$f?width=500}}" >> "$File".md
echo -e "\n[[+$f]]" >> "$foldermonth"/"$calendarfile"
echo -e "{{$f?width=500}}" >> "$foldermonth"/"$calendarfile"
mv "$f" $folder/"$f"
mv "$File".md $folder/"$File".md
echo "cd $folder"
kate $folder/"$File".md 2>/dev/null &
```



