# ttvidc
Created Montag [Zettelkasten:2022:03:07]()
Backlink [CodeFabrik:GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] FRAGMENT **ttvidc**
	- [ ] both files selectable
	- [ ] combine with [ttnc](./ttnc.md)

## Features
- heruntergeladene Videos von Mediathek in Markdown Dateien umwandeln
- Zim Syntax wird hinzugefügt
	
Korrektur von Videos die aus der Mediathek oder anderen Quellen heruntergeladen wurden

```bash
noweb.py -Rttvidc ttvidc.md > ttvidc && chmod u+x ttvidc && echo 'fertig'
```

```bash
{{ttvidc}}=
#!/bin/bash
f=$(basename "$1")
oldfilename=${f%.*}
File=$(echo "$f" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
extens=${f##*.} #only the extension of the file
filename=${File%.*} #only the filename


# case of input is txt file
#File2=$(basename "$1")
#extens2=${File2##*.}
#filename2=${File2%.*} #only the filename, here it is the original file
#extens3=${filename2##*.}

if [[ -e "$oldfilename".txt ]]
then
    mv "$oldfilename.mp4" $filename.mp4
    mv "$oldfilename.txt" $filename.mp4.md
    sed -i "1 iContent-Type: text/x-zim-wiki" "$filename".mp4.md
    sed -i "2 iWiki-Format: zim 0.6" "$filename".mp4.md
    sed -i "3 i====== $filename.mp4 ======" "$filename".mp4.md
    sed -i "4 iText creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]") Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$filename".mp4)" "$filename".mp4.md
    sed -i "5 i@ARCHIV2 @VIDEO " "$filename".mp4.md
    sed -i "6 i[*] **[[../"$filename".mp4]]**" "$filename".mp4.md
    #sed -i "7 i" "$filename".mp4.md
    ffmpeg -loglevel quiet -ss 2 -i "$filename".mp4  -t 1 -f image2 "$filename".png
    #convert "$filename".png -resize 1200x1200 "$filename".avif
    sed -i "7 i{{../$filename.png?width=500}}" "$filename".mp4.md
fi

@
```

