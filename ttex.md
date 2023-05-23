# ttex
* ☑ **[../ttex](./ttex)**

- [X] ttex 

Verschiebung von tex Dateien in einen gesammelten Ordner

## Features
* Integration ins [GedankenspeicherCoding:ttn](./ttn.md) Programm
* Dateiname wird mit korrigiert


Text creation time:
[Zettelkasten:2021:04:29]()
Modification time:
[Zettelkasten:2021:04:22]()

``  noweb.py -Rttex ttex.md > ttex && chmod u+x ttex && echo 'fertig'``


```bash
{{ttex}}=
#!/bin/bash
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
#f=$(basename "$1")
mv "$1" "$File"
filename=$(basename "$File" .tex)
f=$(basename "$1" .tex)
folder="$filename"-tex
mkdir "$folder" #
mv "$1".pdf "$filename".pdf
mv "$1".log "$filename".log
mv "$1".aux "$filename".aux
mv "$1".synctex.gz "$filename".synctex.gz
mv "$filename".* "$folder"/ #
#touch "$folder".md #
echo "Content-Type: text/x-zim-wiki" >> "$folder".md
echo "Wiki-Format: zim 0.6" >> "$folder".md
echo "[*] @TEX **$folder**" >> "$folder".md #
echo "**[[./$File]]**" >> "$folder".md 
echo "**[[./$filename.pdf]]**" >> "$folder".md 
echo "Text creation time:" >> "$folder".md
date +"[[Zettelkasten:%Y:%m:%d]]">> "$folder".md
echo "Modification time:" >> "$folder".md
date +'[[Zettelkasten:%Y:%m:%d]]' -r "$folder"/"$File" >> "$folder".md
ln -s "$folder"/"$File" "$File"
ln -s "$folder"/"$filename".pdf "$filename".pdf
#kate "$folder".md 2>/dev/null &
@
```

