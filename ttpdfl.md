# ttpdfl

* ☑ **ttpdfl**  

Created Samstag [Zettelkasten:2021:06:05]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

  ``noweb.py -Rttpdfl ttpdfl.txt > ttpdfl && chmod u+x ttpdfl && echo 'fertig``'


```awk
<<ttpdfl>>=
#!/bin/bash
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
f=$(basename "$1")
folder=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d" -r "$1")
mkdir -p $folder
touch "$File".txt
echo "Content-Type: text/x-zim-wiki" >> "$File".txt
echo "Wiki-Format: zim 0.6" >> "$File".txt
echo "[*] @ARTIKEL **[[../$f]] >  2277-11-11 $2**" >> "$File".txt
echo "Text creation time:" >> "$File".txt
date +"[[Zettelkasten:%Y:%m:%d]]">> "$File".txt
echo "Modification time:" >> "$File".txt
date +"[[Zettelkasten:%Y:%m:%d]]" -r "$1" >> "$File".txt
echo -e "[[../]]\n$2\n\n" >> "$File".txt
pdfinfo "$1" | grep Pages >> "$File".txt
echo -e "\n" >> "$File".txt
pdftotext -f 1 -l 1 "$1" ->> "$File".txt
mv "$1" $folder/"$1"
mv "$File".txt $folder/"$File".txt
ln -s $folder/"$1" "$f"
ln -s $folder/"$File".txt "$File".txt
echo "cd $folder"
#kate $folder/"$File".txt 2>/dev/null &
#okular $folder/"$1" 2>/dev/null &
@

```


