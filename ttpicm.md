# ttpicm

- [X] **ttpicm**

Angelegt Montag [Zettelkasten:2021:05:03]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

``noweb.py -Rttpicm ttpicm.md > ttpicm && chmod u+x ttpicm && echo 'fertig'``

```bash
{{ttpicm}}=
#!/bin/bash
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
f=$(basename "$1")
folder=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d" -r "$1")
foldermonth=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m" -r "$1")
mkdir -p $folder
calendarfile=$(date +"%d" -r "$f")
calendarfile=$calendarfile.md
if [[ ! -e "$foldermonth"/"$calendarfile" ]]
then
    touch "$foldermonth"/"$calendarfile"
    date +"===== %A %d %b %Y ====="  -r "$f">> "$foldermonth"/"$calendarfile"
    #date +"[[:Zettelkasten:%Y:%W|Week %W]]"   -r "$f">> "$foldermonth"/"$calendarfile"
    date +"[[Zettelkasten:%Y:%m]]"  -r "$f">> "$foldermonth"/"$calendarfile"
    echo -e "[[../]]"  >> "$foldermonth"/"$calendarfile"
    date +"[*] **%A %d %b %Y ** "  -r "$f" >> "$foldermonth"/"$calendarfile"
    #mv "$calendarfile" "$foldermonth"/"$calendarfile"
fi
touch "$File".md
echo "Content-Type: text/x-zim-wiki" >> "$File".md
echo "Wiki-Format: zim 0.6" >> "$File".md
echo "[*] @BILD $3 **[[../$f]] $2**" >> "$File".md
echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" >> "$File".md
echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$1")" >> "$File".md
echo -e "[[../]]\n$4\n" >> "$File".md
echo "{{../$f?width=750}}" >> "$File".md
echo -e "\n[[+$f]]" >> "$foldermonth"/"$calendarfile"
echo -e "{{$f?width=750}}" >> "$foldermonth"/"$calendarfile"
mv "$f" $folder/"$f"
mv "$File".md $folder/"$File".md
echo "cd $folder"
kate $folder/"$File".md 2>/dev/null &
@
```



