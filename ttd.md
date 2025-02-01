# ttd
[Zettelkasten:2021:04:22]()
- [X] **[../ttd](./ttd)**

In einem Verzeichnis alle Dateien mit einer Textdatei versehen

*run-cell.sh*
```bash
noweb.py -Rttd ttd.md > ttd && chmod u+x ttd && echo 'fertig'
```

*ttd*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"

folder="$1"
folder=$(echo $folder | sed 's/\///g')
#ls --hide=*.md "$folder" > f
list=$(ls -1 --hide=*.md "$folder")
foldertxt=${folder%.*}
lines="$(wc --lines <<< "$list")"

for (( i=$lines ; i>=1 ; i-- )); 
do
	element=$(sed -n "${i}p" <(echo "$list"))
	#echo "$element"
	#f=$(basename $element)
	#for f in $list;
	#do 
	File=$(echo "$element" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
	#echo $File
	mv -n "$foldertxt"/"$element" "$foldertxt"/"$File"
	g=$(basename "$File")
	extens=${g##*.}
	Filena=${File%.*}
	extenspdf=$(echo $File | grep -o pdf)
	extensxopp=$(echo $File | grep -o xopp)
	extensmp4=$(echo $File | grep -o mp4)
	extensmov=$(echo $File | grep -o mov)
	extensmkv=$(echo $File | grep -o mkv)
	extensflv=$(echo $File | grep -o flv)
	Unterricht=$(echo $File | grep -o Unterrichtsnotiz)

	if [[ $(echo $File | grep -o Unterrichtsnotiz) == Unterrichtsnotiz || $(echo $File | grep -o Unterrichtsnotizen) == Unterrichtsnotizen ]]
	then
		source="Christian Gößl"
		tags="@Unterricht @Nachhilfe"
		additiontext=""
	fi
	function Wikiprev(){
		touch "$folder"/"$File".md
		echo "Content-Type: text/x-zim-wiki" >> "$folder"/"$File".md
		echo "Wiki-Format: zim 0.6" >> "$folder"/"$File".md
		#echo "===== $File =====" >> "$folder"/"$File".md
		echo "# $File" >> "$folder"/"$File".md
	}

	function Timestamps(){
		echo "Text creation time: $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]") Modification time: $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]" -r "$folder"/"$g")" >> "$folder"/"$File".md
		#echo "" >> "$folder"/"$File".md
	}

	if [ -e "$folder"/"$File".md ]; 
	then
		echo no
	else
		if [[ pdf == $extens ]]
		then
			#echo pdf
			ttpdf "$folder"/"$g" "$source" "$tags" "$additiontext" 
		elif [[ JPEG == $extens || jpg == $extens || png == $extens || webp == $extens || jpeg == $extens || svg == $extens ]] && [[ -z $extenspdf && -z $extensxopp && -z $extensmp4 && -z $extensmov && -z $extensflv && -z $extensmkv ]]
		then
			#echo pic
			ttpic "$folder"/"$g" "$source" "$tags" "$additiontext" 
			#echo yes
		elif [[ mp4 == $extens || mov == $extens || mkv == $extens || flv = $extens ]]
		then
			#echo vid
			#ttdown "$folder"/"$g" "$2"
			filena=${g%.*} #only the filename
			if [[ -e "$filena".md && ! -d "$filena" ]]; 
			then
                ttvidc "$Filename"
            fi
			Wikiprev
			Timestamps
			echo "- [X] **[[../$Filename]]** " >> "$folder"/"$File".md
			echo "$source" >> "$folder"/"$File".md
			ffmpeg -loglevel quiet -ss 2 -i "$folder"/"$File"  -t 1 -f image2 "$folder"/"$File".png
			convert "$folder"/"$File".png -resize 1200x1200 "$folder"/"$File".avif
			rm "$folder"/"$File".png
			echo -e "\n$additiontext\n" >> "$folder"/"$File".md
			echo "{{../$File.avif?width=500}}" >> "$folder"/"$File".md
			echo "$3" >> "$folder"/"$File".md
		elif [[ epub == $extens ]]
		then
			Wikiprev
			Timestamps
			echo "- [X] @EBOOK $3 **[[../$f]] $2**" >> "$folder"/"$File".md
			echo -e "\n$2\n" >> "$folder"/"$File".md
			einfo "$folder"/"$g" >> "$folder"/"$File".md
			#Opentxt
		elif [[ eml == $extens ]]
		then
			Wikiprev
			Timestamps
			echo "- [X] @EMAIL $3 **[[../$f]] $2**" >> "$folder"/"$File".md
			echo -e "\n$2\n" >> "$folder"/"$File".md
			cat "$folder"/"$g" >> "$folder"/"$File".md
			#Opentxt
		elif [[ maff == $extens ]]
		then
			Wikiprev
			Timestamps
			folder2=$(unzip -Z -1 "$foldertxt"/"$g" '*/')
			echo $folder2
			unzip "$foldertxt"/"$g" -d $foldertxt
			echo "- [X] @WEB $3 **[[../$g]] $2 $(cat "$foldertxt"/$folder2'index.dat' | grep source | cut -f 2)**" >> "$foldertxt"/"$File".md
			echo -e "\n$2\n" >> "$folder"/"$File".md
			cat "$foldertxt"/$folder2'index.rdf' >> "$foldertxt"/"$File".md
			#pandoc -f html -t zimwiki $folder'index.html' >> "$File".md
			rm -r "$foldertxt"/"$folder2"
			#Opentxt
		elif [[ $extens == xopp ]]
		then
			echo xopp
			filename=$(basename "$folder"/"$File" .xopp)
			Wikiprev
			echo "- [X] $tags **[[../$Filename]] $source**" >> "$folder"/"$File".md
			Timestamps
			echo -e "\n$additiontext\n" >> "$folder"/"$File".md
			xournalpp --export-range=1 "$folder"/"$File" -i "$folder"/"$File".png
			#convert "$folder"/"$File".png -resize 1200x1200 -quality 97 "$folder"/"$File"-px.png
			#mv "$folder"/"$File"-px.png "$folder"/"$File".png
			convert "$folder"/"$File".png "$folder"/"$File".avif
			rm "$folder"/"$File".png
			echo -e "{{../$File.avif?width=500}}\n" >> "$folder"/"$File".md
			#xournalpp "$folder"/"$File" -p "$folder"/"$filename".pdf
			#ttpdf "$folder"/"$filename".pdf
		elif [[ -n $extenspdf || -n $extensxopp || -z $extensmp4 || -z $extensmov || -z $extensflv || -z $extensmkv ]]
		then
			echo "tue nichts"
		elif [[ $extens == $g ]]
		then
			Wikiprev
			echo "- [X] @ORDNER $3 **[[../$g]] $2**" >> "$folder"/"$File".md
			Timestamps
			echo -e "\n$2\n" >> "$folder"/"$File".md
			#Opentxt
		else 
			#echo else
			Wikiprev
			echo "- [X] $3 **[[../$g]] $2**" >> "$folder"/"$File".md
			Timestamps
			echo -e "\n$2\n" >> "$folder"/"$File".md
			#Opentxt
		fi

	fi
	
	#echo "[[./$File]]" >> "$foldertxt".md
	#echo "[[+$File]]" >> "$foldertxt".md
done
```

