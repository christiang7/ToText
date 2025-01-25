# ttdpicm

- [X] **ttdpicm**

Created Freitag [Zettelkasten:2021:06:04]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

  ``noweb.py -Rttdpicm ttdpicm.md > ttdpicm && chmod u+x ttdpicm && echo 'fertig'``

*ttdpicm*
```bash
#!/bin/bash
ls --hide=*.md "$1" > f
while read f
do
  filetxt=$(echo "$f" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
  filename=$(basename "$f")
  folder=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d" -r "$1"/"$filename")
  mkdir -p $folder
  touch "$1"/"$filetxt".md
  echo "Content-Type: text/x-zim-wiki" >> "$1"/"$filetxt".md
  echo "Wiki-Format: zim 0.6" >> "$1"/"$filetxt".md
  echo "[*] @BILD $3 **[[../$filename]] $2**" >> "$1"/"$filetxt".md
  echo "Text creation time:" >> "$1"/"$filetxt".md
  date +"[[Zettelkasten:%Y:%m:%d]]" >> "$1"/"$filetxt".md
  echo "Modification time:" >> "$1"/"$filetxt".md
  date +"[[Zettelkasten:%Y:%m:%d]]" -r "$1"/"$filename" >> "$1"/"$filetxt".md
  echo "{{../$filename?width=500}}" >> "$1"/"$filetxt".md
  echo -e "\n$4\n" >> "$1"/"$filetxt".md
  mv "$1"/"$filename" "$folder"/"$filename"
  mv "$1"/"$filetxt".md "$folder"/"$filetxt".md
done < f
rm f
```




