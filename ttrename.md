# ttrename
Created Dienstag [Zettelkasten:2022:06:14]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **ttrename**
	- [ ] Anpassung auch für Ordner
	- [ ] Anpassung bei beliebigen Dateinamen mit doppelten oder keiner Dateiendung
		- [ ] mittels file und cut kann man die Dateiendung herausfinden und ansetzen file   Screenshot_2022-07-26_at_22-51-47_The_mountain_landscape_-_Ferdinand_Engelműller_-_Google_Arts_\&_Culture.png | cut -d ' ' -f 2
		https://www.geeksforgeeks.org/how-to-find-out-file-types-in-linux/ | How to Find Out File Types in Linux - GeeksforGeeks


## Informations

- [X] WEB bash - Extract string from brackets - Stack Overflow

 <https://stackoverflow.com/questions/7209629/extract-string-from-brackets>
to extract the file from the txt file to correct the name
```bash
echo "string1 [[string2]] string3 string4" | sed 's/.*\[\[\([^]]*\)\]\].*/\1/g'
```

```bash
cat Brief_Overview_of_Japanese_Art_of_Archery.pdf.md | tr '\n' ' ' | cut -d "[" -f4 | cut -d "]" -f1 | sed "s/..\///g"
```


- [X] WEB Zenity - Create GUI Dialog Boxes In Bash Scripts - OSTechNix

 <https://ostechnix.com/zenity-create-gui-dialog-boxes-in-bash-scripts/>


## Main program

```bash
noweb.py -Rttrename ttrename.md > ttrename && echo 'fertig'
```

```bash
chmod u+x ttrename && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Gedankenwanderung/Programme/ttrename ~/.local/bin/ttrename && echo 'fertig'
```

```bash

{{ttrename}}=
#!/bin/bash

#case of input file is the original file
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
f=$(basename "$1")
extens=${f##*.}
filename=${f%.*}

# case of input is md file
File2=$(basename "$1")
extens2=${File2##*.}
filename2=${File2%.*} #only the filename, here it is the original file
extens3=${filename2##*.}
#echo "${File2}"
#echo $extens2
#echo "${filename2}"
if [[ $extens2 == md ]]
then
	Newname=$(zenity --entry \
       --width 500 \
       --title "Type new filename" \
       --text "Enter new filename" \
       --entry-text "$(basename ${filename2} .$extens3)")
    if [ ! $? -eq 1 ];
    then
        Newname=$(echo "$Newname" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
        mv "$filename2" "$Newname"."$extens3"
        mv "${filename2%.*}" "$Newname"
        mv "${filename2%.*}"_files "$Newname"_files
        mv "${filename2%.*}"-Dateien "$Newname"-Dateien
        mv "${filename2%.*}"_Dateien "$Newname"_Dateien
        mv "$filename2".png "$Newname"."$extens3".png
        mv "$filename2".avif "$Newname"."$extens3".avif
        mv "$File2" "$Newname"."$extens3".md
        ttncc "$filename2" "$Newname"."$extens3"
        echo "$Newname"."$extens3"
    fi
else 
	Newname=$(zenity --entry \
       --width 500 \
       --title "Type new filename" \
       --text "Enter new filename" \
       --entry-text "$filename")
    if [ ! $? -eq 1 ];
    then
        Newname=$(echo "$Newname" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
        mv "$f" "$Newname"."$extens"
        mv "$f" "$Newname"
        mv "${f%.*}" "$Newname"
        mv "${f%.*}"_files "$Newname"_files
        mv "${f%.*}"-Dateien "$Newname"-Dateien
        mv "${f%.*}"_Dateien "$Newname"_Dateien
        mv "$f".png "$Newname"."$extens".png
        mv "$f".avif "$Newname"."$extens".avif
        mv "$File".md "$Newname"."$extens".md
        ttncc "$f" "$Newname"."$extens"
        echo "$Newname"."$extens"
    fi
fi


@
```

