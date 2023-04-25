# ttpicl
Created Montag [Zettelkasten:2022:02:21]()
Backlink[ GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **ttpicl**  


  ``noweb.py -Rttpicl ttpicl.txt > ttpicl && chmod u+x ttpicl && echo 'fertig``'


```awk
<<ttpicl>>=
#!/bin/bash
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
f=$(basename "$1")
folder=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d" -r "$1")
mkdir -p $folder
touch "$File".txt
echo "Content-Type: text/x-zim-wiki" >> "$File".txt
echo "Wiki-Format: zim 0.6" >> "$File".txt
echo "[*] @BILD **[[../$f]] $2**" >> "$File".txt
echo "Text creation time:" >> "$File".txt
date +"[[Zettelkasten:%Y:%m:%d]]" >> "$File".txt
echo "Modification time:" >> "$File".txt
date +"[[Zettelkasten:%Y:%m:%d]]" -r "$1" >> "$File".txt
echo -e "[[../]]$2\n" >> "$File".txt
echo "{{../$f?width=750}}" >> "$File".txt
mv "$1" $folder/"$1"
mv "$File".txt $folder/"$File".txt
ln -s $folder/"$1" "$f"
ln -s $folder/"$File".txt "$File".txt
echo "cd $folder"
kate $folder/"$File".txt 2>/dev/null &
@
```


