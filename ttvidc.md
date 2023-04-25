# ttvidc
Created Montag [Zettelkasten:2022:03:07]()
Backlink [CodeFabrik:GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ FRAGMENT **ttvidc**  >  2277-11-11


Korrektur von Videos die aus der Mediathek oder anderen Quellen heruntergeladen wurden, vielleicht Verbindung mit dem Programm [ttnc](./ttnc.md)

  ``noweb.py -Rttvidc ttvidc.txt > ttvidc && chmod u+x ttvidc && echo 'fertig``'

```awk
<<ttvidc>>=
#!/bin/bash
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
f=$(basename "$1")

extens=${f##*.} #only the extension of the file
filename=${f%.*} #only the filename
if [[ -e "$filename".txt ]] 
then
	mv "$filename".txt "$File".txt
	sed -i "1 iContent-Type: text/x-zim-wiki" "$File".txt
	sed -i "2 iWiki-Format: zim 0.6" "$File".txt
	sed -i "3 i===== $File =====" "$File".txt
	sed -i "4 i[*] @ARCHIV2 @VIDEO **[[../$f]] $2**" "$File".txt
	#echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" >> "$File".txt
	#echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$1")" >> "$File".txt
	sed -i "5 iText creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" "$File".txt
	sed -i "6 iModification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$1")" "$File".txt
	sed -i "7 i[[../]]\n" "$File".txt
	ffmpeg -loglevel quiet -ss 2 -i "$File"  -t 1 -f image2 "$File".png
	convert "$File".png -resize 1200x1200 -quality 97 "$File"-px.png
	mv "$File"-px.png "$File".png
	sed -i "8 i{{../$File.png?width=750}}" "$File".txt
fi

@
```

