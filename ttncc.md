# ttncc
Created Freitag [Zettelkasten:2022:05:20]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **ttncc**


```bash
noweb.py -Rttncc ttncc.md > ttncc && chmod u+x ttncc && echo 'fertig'
```


  
```bash
{{ttncc}}=
#!/bin/bash
File=$(echo "$2" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
oldFile=$(basename "$1")
f=$(basename "$File")
filename=${f%.*} #only the filename
extens=${f##*.}
function Opentxt(){
	kate "$File".md 2>/dev/null &
}

function Wikiprev(){
	touch "$File".md
}

if [[ pdf == $extens ]]
then
	#Wikiprev
	rm "$oldFile".png
	rm "$oldFile".avif
	pdftoppm -png -singlefile "$File" "$File"
	convert "$File".png -resize 1200x1200 "$File".avif
	rm "$File".png
	sed -i "1 s/$oldFile/$f/" "$File".md
	sed -i "2 s/$oldFile/$f/" "$File".md
	sed -i "3 s/$oldFile/$f/g" "$File".md
	sed -i "4 s/$oldFile/$f/g" "$File".md
	sed -i "5 s/$oldFile/$f/g" "$File".md
	sed -i "6 s/$oldFile/$f/g" "$File".md
	#sed -i "s/$oldFile/$f/g" "$File".md
	sed -i "s/$oldFile.png/$f.avif/g" "$File".md
	sed -i "s/$oldFile.avif/$f.avif/g" "$File".md
	#Opentxt
elif [[ jpg == $extens || png == $extens || webp == $extens || jpeg == $extens || avif == $extens ]]
then
	#sed -i "3 i[*] @BILD **[[../$f]] $2**" "$File".md
    sed -i "1 s/$oldFile/$f/" "$File".md
    sed -i "2 s/$oldFile/$f/" "$File".md
	sed -i "3 s/$oldFile/$f/" "$File".md
	sed -i "4 s/$oldFile/$f/" "$File".md
	sed -i "5 s/$oldFile/$f/g" "$File".md
	sed -i "6 s/$oldFile/$f/g" "$File".md
	#sed -i "s/$oldFile/$f/g" "$File".md
	#Wikiprev
	#sed -i "11 i{{../$f?width=500}}" "$File".md
	#Opentxt
elif [[ mp4 == $extens || mov == $extens || mkv == $extens || flv = $extens  ]]
then
	#sed -i "3 i[*] @VIDEO **[[../$f]]** $2" "$File".md
	rm "$oldFile".png
	ffmpeg -loglevel quiet -ss 2 -i "$File"  -t 1 -f image2 "$File".png
	convert "$File".png -resize 4000x4000 "$File".avif
	rm "$File".png
	sed -i "1 s/$oldFile/$f/" "$File".md
	sed -i "2 s/$oldFile/$f/" "$File".md
	sed -i "3 s/$oldFile/$f/g" "$File".md
	sed -i "4 s/$oldFile/$f/g" "$File".md
	sed -i "5 s/$oldFile/$f/g" "$File".md
	sed -i "6 s/$oldFile/$f/g" "$File".md
	#sed -i "s/$oldFile/$f/g" "$File".md
	sed -i "s/$oldFile.png/$f.avif/g" "$File".md
	sed -i "s/$oldFile.avif/$f.avif/g" "$File".md
	#Wikiprev
	#Opentxt
elif [[ epub == $extens ]]
then
	sed -i "1 s/$oldFile/$f/" "$File".md
	sed -i "2 s/$oldFile/$f/" "$File".md
	sed -i "3 s/$oldFile/$f/g" "$File".md
	sed -i "4 s/$oldFile/$f/g" "$File".md
	sed -i "5 s/$oldFile/$f/g" "$File".md
	sed -i "6 s/$oldFile/$f/g" "$File".md
	#sed -i "s/$oldFile/$f/g" "$File".md
	#Wikiprev
	#Opentxt
elif [[ $extens == $f ]]
then
	sed -i "1 s/$oldFile/$f/" "$File".md
	sed -i "3 s/$oldFile/$f/g" "$File".md
	sed -i "4 s/$oldFile/$f/g" "$File".md
	sed -i "5 s/$oldFile/$f/g" "$File".md
	sed -i "6 s/$oldFile/$f/g" "$File".md
	#sed -i "s/$oldFile/$f/g" "$File".md
	#Wikiprev
	#Opentxt
else
	sed -i "1 s/$oldFile/$f/" "$File".md
	sed -i "2 s/$oldFile/$f/" "$File".md
	sed -i "3 s/$oldFile/$f/g" "$File".md
	sed -i "4 s/$oldFile/$f/g" "$File".md
	sed -i "5 s/$oldFile/$f/g" "$File".md
	sed -i "6 s/$oldFile/$f/g" "$File".md
	#sed -i "s/$oldFile/$f/g" "$File".md
	#Wikiprev
	#Opentxt
fi

@ 
```

