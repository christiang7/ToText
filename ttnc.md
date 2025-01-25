# ttnc
Created Freitag [Zettelkasten:2022:02:25]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **ttnc**


```bash
noweb.py -Rttnc ttnc.md > ttnc && chmod u+x ttnc && echo 'fertig'
```

*ttnc*
```bash
#!/bin/bash
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
f=$(basename "$1")
filename=${f%.*} #only the filename
extens=${f##*.}
line=$(head -n 1 "$File".md)
#echo $extens
function Opentxt(){
	kate "$File".md 2>/dev/null &
}

function Wikiprev(){
	touch "$File".md
	sed -i "1 i====== $File ======" "$File".md
	sed -i "1 iWiki-Format: zim 0.6" "$File".md
	sed -i "1 iContent-Type: text/x-zim-wiki" "$File".md
}

function Timestamps(){
	echo "Text creation time:" >> "$File".md
	date +"[[Zettelkasten:%Y:%m:%d]]">> "$File".md
	echo "Modification time:" >> "$File".md
	date +"[[Zettelkasten:%Y:%m:%d]]" -r "$f" >> "$File".md
}

if [[ pdf == $extens ]]
then
	sed -i "1 i[*] @ARTIKEL **[[../$f]]  $2**" "$File".md
	Wikiprev
	Timestamps
	echo -e "\n$2\n" >> "$File".md
	pdfinfo "$1" | grep Pages >> "$File".md
	echo -e "\n" >> "$File".md
	pdftoppm -png -singlefile "$File" "$File"
	sed -i "13 i{{../$File.png?width=500}}" "$File".md
	pdftotext -f 1 -l 1 "$1" ->> "$File".md
	Opentxt
elif [[ jpg == $extens || png == $extens || webp == $extens || jpeg == $extens || avif == $extens ]]
then
	sed -i "1 i[*] @BILD **[[../$f]] $2**" "$File".md
	Wikiprev
	Timestamps
	echo -e "[[..]]\n$2\n" >> "$File".md
	echo "{{../$f?width=500}}" >> "$File".md
	Opentxt
elif [[ mp4 == $extens || mov == $extens || mkv == $extens || flv = $extens  ]]
then
	sed -i "1 i[*] @VIDEO **[[../$f]]** $2" "$File".md
	Wikiprev
	Timestamps
	echo -e "[[..]]\n$2\n" >> "$File".md
	Opentxt
elif [[ epub == $extens ]]
then
	sed -i "1 i[*] @EBOOK $3 **[[../$f]] $2**" "$File".md
	Wikiprev
	Timestamps
	echo -e "\n$2\n" >> "$File".md
	einfo "$1" >> "$File".md
	Opentxt
elif [[ $extens == $f ]]
then
	sed -i "1 i[*] @ORDNER $3 **[[../$f]] $2**" "$File".md
	Wikiprev
	Timestamps
	echo -e "\n$2\n" >> "$File".md
	Opentxt
elif [[ $extens == md ]] 
then
	if [ "$line" != "Content-Type: text/x-zim-wiki" ]; 
		then
		sed -i "1 i[*] @ORDNER $3 **[[../$f]] $2**" "$File"
		sed -i "1 iWiki-Format: zim 0.6" "$File"
		sed -i "1 iContent-Type: text/x-zim-wiki" "$File"
		echo "Text creation time:" >> "$File"
		date +"[[Zettelkasten:%Y:%m:%d]]">> "$File"
		echo "Modification time:" >> "$File"
		date +"[[Zettelkasten:%Y:%m:%d]]" -r "$filename" >> "$File"
		echo -e "\n$2\n" >> "$File"
	fi
	kate "$File" 2>/dev/null &
	else
	sed -i "1 i[*] $3 **[[../$f]] $2**" "$File".md
	Wikiprev
	Timestamps
	#echo -e "$2\n" >> "$File".md
	echo -e "\n$2\n" >> "$File".md
	Opentxt
fi
```

