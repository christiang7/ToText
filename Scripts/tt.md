# tt
Text creation time: [Zettelkasten:2021:04:29]() Modification time: [Zettelkasten:2021:01:04]() File date: [Zettelkasten:2021:04:24]()

Das ist das Skript zum erstellen von Textdateien für andere uneditierbare Dateien


## Features

### 2025-01-31 merge of original tt with ttn
original tt file
```bash
#!/bin/bash
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
touch "$File".md
echo "$2" >> "$File".md
nano "$File".md
```

### 2024-02-13 combined ttn with tts
The tts program is now integrated in the ttn program. The workflow is now better and just one request.

### 2023-10-30 tex Format supported
tex format support again


Hier sind die Dolpin ServiceMenüs
[KDE-Servicemenüs › Wiki › ubuntuusers-de]()


- [X] WEB How to get File Name and extension in bash|shell script programming https://www.w3schools.io/terminal/bash-extract-file-extension/
- [X] WEB Bash Scripting - How to check If File Exists - GeeksforGeeks https://www.geeksforgeeks.org/bash-scripting-how-to-check-if-file-exists/
- [X] WEB Zenity - Create GUI Dialog Boxes In Bash Scripts - OSTechNix https://ostechnix.com/zenity-create-gui-dialog-boxes-in-bash-scripts/
- [X] WEB Bash Conditional Statements - OSTechNix https://ostechnix.com/bash-conditional-statements/


Preserve image's modification time with mogrify/imagemagick | AnonymousOverflow
https://overflow.adminforge.de/exchange/unix/questions/431836/preserve-images-modification-time-with-mogrify-imagemagick

## Program

*run-cell.sh*
```bash
noweb.py -Rtt tt.md > tt && chmod u+x tt && echo 'tt' && date
```

using ``tt`` function with the parameters as following
```bash
    tt p1 p2 p3 p4 p5
    p1 - file
    p2 - tags
    p3 - source
    p4 - additiontext
    p5 - switch for using yad or not
```


*tt*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
source tt-lib.sh;

echo $1
#ofile="$1"
ofile=$(basename "$1")
folder=$(dirname "$(realpath "$ofile")")
#ofile=$(basename "$file")
echo $ofile
extens=${ofile##*.}
Filename=${ofile%.*}
#folder=$(pwd)
Unterricht=$(echo $File | grep -o Unterrichtsnotiz)
File=$(cleanName "$ofile")
yadSwitch=$5
echo $folder
if [[ -e "$File".md ]]
then
	line=$(head -n 1 "$Filename".md)
	#echo $line
	if [[ "$line" != "Content-Type: text/x-zim-wiki" ]]
		then
		# just via cat program correcting like in the video function ttvid
		ttnc "$ofile"
	fi
	xdg-open "$File" &
else
    if [[ $(echo $Filename | grep -o Unterrichtsnotiz) == Unterrichtsnotiz || $(echo $Filename | grep -o Unterrichtsnotizen) == Unterrichtsnotizen || $(echo $Filename | grep -o Unterricht) == Unterricht ]]
    then
        source="Christian Gößl"
        tags="@Unterricht @Nachhilfe"
    else
        source="$2"
        tags="$3"
        additiontext="$4"
    fi
    if [[ $yadSwitch == "" ]]
    then
		abfrage=$(yad --title="Create md file" --text="Anything to add?" \
		--form --width 500 --separator="~" --item-separator=","  \
		--field="Name" \
		--field="Source:":CBE \
		--field="Tags" \
		--field="Keep picture:":CB \
		--field="Show file:":CB \
		--field="Something more":TXT \
		"$Filename" "$source,Internet,Christian Gößl" "$tags" "Yes,No" "No,Yes" "$additiontext")
    fi
fi

if [ ! $? -eq 1 ];
then
    if [[ $yadSwitch == "" ]]
    then
		Newname=$(echo $abfrage | cut -s -d "~" -f 1)
		if [[ $extens == $ofile ]]
		then
			File=$(cleanName "$Newname")
		else
			File=$(cleanName "$Newname.$extens")
		fi
		source=$(echo $abfrage | cut -s -d "~" -f 2)
		tags=$(echo $abfrage | cut -s -d "~" -f 3)
		origpic=$(echo $abfrage | cut -s -d "~" -f 4)
		showfile=$(echo $abfrage | cut -s -d "~" -f 5)
		additiontext=$(echo $abfrage | cut -s -d "~" -f 6)
	else
		source="$2"
        tags="$3"
        additiontext="$4"
		origpic="yes"
		showfile="no"
	fi
	mv "$folder"/"$ofile" "$folder"/"$File"
	extens=${File##*.}
	Filename=${File%.*}
	extenspdf=$(echo "$folder"/"$File" | grep -o pdf)
	extensxopp=$(echo "$folder"/"$File" | grep -o xopp)
	extensmp4=$(echo "$folder"/"$File" | grep -o mp4)
	extensmov=$(echo "$folder"/"$File" | grep -o mov)
	extensmkv=$(echo "$folder"/"$File" | grep -o mkv)
	extensflv=$(echo "$folder"/"$File" | grep -o flv)

	if [[ pdf == $extens ]]
	then
		ttpdf "$folder" "$File" "$source" "$tags" "$additiontext" "yes"
	elif [[ jpg == $extens || PNG == $extens || JPEG == $extens || png == $extens || webp == $extens || jpeg == $extens || avif == $extens ]] && [[ -z $extenspdf && -z $extensxopp && -z $extensmp4 && -z $extensmov && -z $extensflv && -z $extensmkv ]]
	then
		# || tif == $extens || tiff == $extens
		convert "$folder"/"$File" "$folder"/"$Filename".avif
		touch -r "$File" "$Filename".avif # make the original modification time
		ttpic "$folder" "$Filename".avif "$source" "$tags" "$additiontext"
		if [[ $origpic == "No" ]];
		then
			rm "$File"
		fi
	elif [[ mp4 == $extens || mov == $extens || mkv == $extens || flv = $extens || ogv = $extens ]]
	then
		ttvid "$folder" "$File" "$tags" "$source" "$additiontext" "$ofile" "yes"
	elif [[ epub == $extens ]]
	then
		file-description "$folder" "$File" "@Ebook $tags" "$source" "$additiontext" "" "yes"
		einfo "$folder"/"$File" >> "$folder"/"$File".md
	elif [[ eml == $extens ]]
	then
		file-description "$folder" "$File" "@Email $tags" "$source" "$additiontext" "" "yes"
		cat "$folder"/"$File" >> "$folder"/"$File".md
	elif [[ maff == $extens ]]
	then
		file-description "$folder" "$File" "@Web $tags" "$source" "$additiontext" "" "yes"
		folder2=$(unzip -Z -1 "$Filename" '*/')
		echo -e " $source $(cat $folder2'index.dat' | grep source | cut -f 2)\n$additiontext\n" >> "$folder"/"$File".md
		cat $folder2'index.rdf' >> "$folder"/"$File".md
		#pandoc -f html -t zimwiki $folder'index.html' >> "$folder"/"$File".md
		rm -r $folder2
	elif [[ cts == $extens ]]
	then
		file-description "$folder" "$File" "@Treesheets $tags" "$source" "$additiontext" "" "yes"
	elif [[ tex == $extens ]]
	then
		ttex "$folder" "$File" "$ofile"
	elif [[ $extens == xopp ]]
	then
		xournalpp --export-range=1 "$folder"/"$File" -i "$folder"/"$File".png
		file-description "$folder" "$File" "@Document $tags" "$source" "$additiontext" "pic" "yes"
		convert "$folder"/"$File".png "$folder"/"$File"/"$File".avif
		rm "$folder"/"$File".png
	elif [[ mp3 == $extens || webm == $extens || flac == $extens || aac = $extens || ogg = $extens || weba = $extens || wav = $extens || aiff = $extens ]]
	then
		file-description "$folder" "$File" "@Musik $tags" "$source" "$additiontext"
	elif [[ $extens == $File ]]
	then
		file-description "$folder" "$File" "$tags" "$source" "$additiontext"
	elif [[ $extens == docx || $extens == doc  || $extens == odt || $extens == ods || $extens == xls || $extens == xlsx || $extens == ppt || $extens == pptx || $extens == odp ]]
	then
		file-description "$folder" "$File" "@Document $tags" "$source" "$additiontext"
	#elif [[ -n $extenspdf | -n $extensxopp || -z $extensmp4 || -z $extensmov || -z $extensflv || -z $extensmkv ]]
	#then
	#	echo "tue nichts"
	else
		file-description "$folder" "$File" "$tags" "$source" "$additiontext" "" "yes"
	fi

fi

if [[ $showfile == "Yes" ]];
then
    if [[ $extens == tex ]]
    then
        File=$(cleanName "$Newname.$extens")
        filename=$(basename "$File" .tex)
        #kate "$filename"_tex.md
        texstudio "$filename"_tex/"$filename".md 2>/dev/null &
    elif [[ jpg == $extens || png == $extens || webp == $extens || jpeg == $extens || avif == $extens ]]
    then
        kate "$filename".avif.md 2>/dev/null &
        xdg-open "$filename".avif 2>/dev/null &
    else
        kate "$File".md 2>/dev/null &
        xdg-open "$File" 2>/dev/null &
    fi
fi
```




