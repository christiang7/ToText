# ttpicl
Created Montag [Zettelkasten:2022:02:21]()
Backlink[ GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **ttpicl**


  ``noweb.py -Rttpicl ttpicl.md > ttpicl && chmod u+x ttpicl && echo 'fertig'``


```bash
{{ttpicl}}=
#!/bin/bash
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
f=$(basename "$1")
folder=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d" -r "$1")
mkdir -p $folder
touch "$File".md
echo "Content-Type: text/x-zim-wiki" >> "$File".md
echo "Wiki-Format: zim 0.6" >> "$File".md
echo "[*] @BILD **[[../$f]] $2**" >> "$File".md
echo "Text creation time:" >> "$File".md
date +"[[Zettelkasten:%Y:%m:%d]]" >> "$File".md
echo "Modification time:" >> "$File".md
date +"[[Zettelkasten:%Y:%m:%d]]" -r "$1" >> "$File".md
echo -e "$2\n" >> "$File".md
echo "{{../$f?width=750}}" >> "$File".md
mv "$1" $folder/"$1"
mv "$File".md $folder/"$File".md
ln -s $folder/"$1" "$f"
ln -s $folder/"$File".md "$File".md
echo "cd $folder"
kate $folder/"$File".md 2>/dev/null &
@
```


