# ttncc
Created Freitag [Zettelkasten:2022:05:20]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **ttncc**

*run-cell.sh*
```bash
noweb.py -Rttncc ttncc.md > ttncc && chmod u+x ttncc && echo 'fertig'
```

using ``ttncc`` function with the parameters as following
```bash
    ttncc p1 p2
    p1 - old file
    p2 - new target file
```
  
*ttncc*
```bash
#!/bin/bash
source tt-lib.sh;

oldFile=$(basename "$1")
File=$(basename "$2")
File=$(cleanName "$File")
#filename=${File%.*} #only the filename
extens=${File##*.}

sed -i "1 s/$oldFile/$File/" "$File".md
sed -i "2 s/$oldFile/$File/" "$File".md
sed -i "3 s/$oldFile/$File/g" "$File".md
sed -i "4 s/$oldFile/$File/g" "$File".md
sed -i "5 s/$oldFile/$File/g" "$File".md
sed -i "6 s/$oldFile/$File/g" "$File".md
if [[ pdf == $extens ]]
then
	#Wikiprev
	rm "$oldFile".png
	rm "$oldFile".avif
	pdftoppm -png -singlefile "$File" "$File"
	convert "$File".png -resize 1200x1200 "$File".avif
	rm "$File".png
	sed -i "s/$oldFile.png/$File.avif/g" "$File".md
	sed -i "s/$oldFile.avif/$File.avif/g" "$File".md
	#Opentxt
elif [[ mp4 == $extens || mov == $extens || mkv == $extens || flv = $extens  ]]
then
	mv "$oldFile".png "$File".png
	mv "$oldFile".avif "$File".avif
	sed -i "s/$oldFile.png/$File.avif/g" "$File".md
	sed -i "s/$oldFile.avif/$File.avif/g" "$File".md
	#Wikiprev
	#Opentxt
fi
```

