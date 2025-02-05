# tt-change
Created Dienstag [Zettelkasten:2022:06:14]()

- [X] **tt-change**
    - [X] Doing
    - [X] Backlog
	- [ ] Anpassung bei beliebigen Dateinamen mit doppelten oder keiner Dateiendung
		- [ ] mittels file und cut kann man die Dateiendung herausfinden und ansetzen ``file Culture.png | cut -d ' ' -f 2``
            - [ ] https://www.geeksforgeeks.org/how-to-find-out-file-types-in-linux/ | How to Find Out File Types in Linux - GeeksforGeeks


## Informations

- [X] Anpassung auch für Ordner erledigt



- [X] WEB bash - Extract string from brackets - Stack Overflow

https://stackoverflow.com/questions/7209629/extract-string-from-brackets
to extract the file from the txt file to correct the name
```bash
echo "string1 [[string2]] string3 string4" | sed 's/.*\[\[\([^]]*\)\]\].*/\1/g'
```

```bash
cat Archery.pdf.md | tr '\n' ' ' | cut -d "[" -f4 | cut -d "]" -f1 | sed "s/..\///g"
```


- [X] WEB Zenity - Create GUI Dialog Boxes In Bash Scripts - OSTechNix

https://ostechnix.com/zenity-create-gui-dialog-boxes-in-bash-scripts/


## Main program

*run-cell.sh*
```bash
noweb.py -Rtt-change tt-change.md > tt-change && echo 'fertig'
```

```bash
chmod u+x tt-change && ln -sf $(pwd)/tt-change ~/.local/bin/tt-change && echo 'fertig'
```

*tt-change*
```bash
#!/bin/bash
source config.sh; # load the config library functions
source tt-lib.sh;

#case of input file is the original file
File=$(cleanName "$1")
#File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
f=$(basename "$1")
extens=${f##*.}
filename=${f%.*}

# case of input is md file
File2=$(basename "$1")
extens2=${File2##*.}
filename2=${File2%.*} #only the filename, here it is the original file
extens3=${filename2##*.} # and the original file extension
#echo "${File2}"
#echo $extens2
#echo "${filename2}"
if [[ $extens2 == md ]]
then
    abfrage=$(yad --title="Enter new filename" --text="Type new filename" \
		--form --width 500 --separator="~" --item-separator=","  \
		--field="Name" \
		--field="Source:":CBE \
		--field="Tags" \
		--field="Something more":TXT \
		"$(basename ${filename2} .$extens3)" "Christian Gößl,Internet," "" "")
    if [ ! $? -eq 1 ];
    then
        Newname=$(echo $abfrage | cut -s -d "~" -f 1)
        Newname=$(cleanName "$Newname")
        source=$(echo $abfrage | cut -s -d "~" -f 2)
        tags=$(echo $abfrage | cut -s -d "~" -f 3)
        additiontext=$(echo $abfrage | cut -s -d "~" -f 4)
        mv "$filename2" "$Newname"."$extens3"
        mv "${filename2%.*}" "$Newname"
        mv "${filename2%.*}"_files "$Newname"_files
        mv "${filename2%.*}"-Dateien "$Newname"-Dateien
        mv "${filename2%.*}"_Dateien "$Newname"_Dateien
        mv "$filename2".png "$Newname"."$extens3".png
        mv "$filename2".avif "$Newname"."$extens3".avif
        mv "$File2" "$Newname"."$extens3".md
        ttc "$filename2" "$Newname"."$extens3"
        sed -i "3 s/\*\*\[\[../$tags\*\*\[\[../" "$Newname"."$extens3".md
        sed -i "4 s/\*\*\[\[../$tags\*\*\[\[../" "$Newname"."$extens3".md
        sed -i "3 s/\]\]/\]\] ${source}/" "$Newname"."$extens3".md
        sed -i "4 s/\]\]/\]\] ${source}/" "$Newname"."$extens3".md
        sed -i "s/\[\[..\/\]\]/\[\[..\/\]\]\n $additiontext/" "$Newname"."$extens3".md
        echo "$Newname"."$extens3"
    fi
else
    abfrage=$(yad --title="Enter new filename" --text="Type new filename" \
		--form --width 500 --separator="~" --item-separator=","  \
		--field="Name" \
		--field="Source:":CBE \
		--field="Tags" \
		--field="Something more":TXT \
		"$filename" "Christian Gößl,Internet," "" "")
    if [ ! $? -eq 1 ];
    then
        Newname=$(echo $abfrage | cut -s -d "~" -f 1)
        Newname=$(cleanName "$Newname")
        source=$(echo $abfrage | cut -s -d "~" -f 2)
        tags=$(echo $abfrage | cut -s -d "~" -f 3)
        additiontext=$(echo $abfrage | cut -s -d "~" -f 4)
        mv "$f" "$Newname"."$extens"
        mv "$f" "$Newname"
        mv "${f%.*}" "$Newname"
        mv "${f%.*}"_files "$Newname"_files
        mv "${f%.*}"-Dateien "$Newname"-Dateien
        mv "${f%.*}"_Dateien "$Newname"_Dateien
        mv "$f".png "$Newname"."$extens".png
        mv "$f".avif "$Newname"."$extens".avif
        mv "$File".md "$Newname"."$extens".md
        ttc "$f" "$Newname"."$extens"
        sed -i "3 s/\*\*\[\[../$tags\*\*\[\[../" "$Newname"."$extens".md
        sed -i "4 s/\*\*\[\[../$tags\*\*\[\[../" "$Newname"."$extens".md
        sed -i "3 s/\]\]/\]\] ${source}/" "$Newname"."$extens".md
        sed -i "4 s/\]\]/\]\] ${source}/" "$Newname"."$extens".md
        sed -i "s/\[\[..\/\]\]/\[\[..\/\]\]\n $additiontext/" "$Newname"."$extens".md
        echo "$Newname"."$extens"
    fi
fi
```

