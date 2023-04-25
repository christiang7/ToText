# ttnl
Created Freitag [Zettelkasten:2022:02:25]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **ttnl**  


  ``noweb.py -Rttnl ttnl.md > ttnl && chmod u+x ttnl && echo 'fertig'``

```bash
{{ttnl}}=
#!/bin/bash
folder=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d" -r "$1")
mkdir -p $folder
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
#f=$(basename "$1")
mv "$1" "$File"
f=$(basename "$File")
extens=${f##*.}

function Linking(){
	mv "$f" $folder/"$f"
	mv "$File".md $folder/"$File".md
	ln -s $folder/"$f" "$f"
	ln -s $folder/"$File".md "$File".md
	echo "cd $folder"
	#kate $folder/"$File".md 2>/dev/null &
}

function Wikiprev(){
	touch "$File".md
	echo "Content-Type: text/x-zim-wiki" >> "$File".md
	echo "Wiki-Format: zim 0.6" >> "$File".md
}

function Timestamps(){
	echo "Text creation time:" >> "$File".md
	date +"[[Zettelkasten:%Y:%m:%d]]">> "$File".md
	echo "Modification time:" >> "$File".md
	date +"[[Zettelkasten:%Y:%m:%d]]" -r "$f" >> "$File".md
}

if [[ -f "$File".md ]]
	then
		Linking
	elif [[ pdf == $extens ]]
		then
		#echo pdf
		ttpdfl "$f"
	elif [[ jpg == $extens || png == $extens || webp == $extens || jpeg == $extens || avif == $extens ]]
	then
		#echo pic
		ttpicl "$f"
	elif [[ mp4 == $extens || mov == $extens || mkv == $extens || flv = $extens  ]]
	then
		Wikiprev
		echo "[*] @VIDEO **[[../$f]]** $2" >> "$File".md
		Timestamps
		echo -e "[[../]]\n$2\n" >> "$File".md
		Linking
	elif [[ epub == $extens ]]
	then
		Wikiprev
		echo "[*] @EBOOK $3 **[[../$f]] $2**" >> "$File".md
		Timestamps
		echo -e "[[../]]\n$2\n" >> "$File".md
		einfo "$f" >> "$File".md
		Linking
elif [[ $extens == $f ]]
then
	Wikiprev
	echo "[*] @ORDNER $3 **[[../$f]] $2**" >> "$File".md
	Timestamps
	echo -e "[[../]]\n$2\n" >> "$File".md
	Linking
else
		Wikiprev
		echo "[*] $3 **[[../$f]] $2**" >> "$File".md
		Timestamps
		#echo -e "$2\n" >> "$File".md
		echo -e "[[../]]\n$2\n" >> "$File".md
		Linking
fi

@ 
```

