# tt-change
Created Dienstag [2022:06:14]()

- [x] **tt-change**
    - [x] Doing
    - [x] Backlog



## Informations

- [x] Anpassung auch für Ordner erledigt

WEB bash - Extract string from brackets - Stack Overflow
https://stackoverflow.com/questions/7209629/extract-string-from-brackets

to extract the file from the txt file to correct the name
```bash
echo "string1 [[string2]] string3 string4" | sed 's/.*\[\[\([^]]*\)\]\].*/\1/g'
```

```bash
cat Archery.pdf.md | tr '\n' ' ' | cut -d "[" -f4 | cut -d "]" -f1 | sed "s/..\///g"
```


WEB Zenity - Create GUI Dialog Boxes In Bash Scripts - OSTechNix
https://ostechnix.com/zenity-create-gui-dialog-boxes-in-bash-scripts/


## Main program

*make.sh*
```bash
noweb.py -Rtt-change tt-change.md > tt-change && date && notify-send -a "Compilation of tt-change" "" "$(date +"%Y-%m-%d") fertig"
```

```bash
chmod u+x tt-change && ln -sf $(pwd)/tt-change ~/.local/bin/tt-change && echo 'fertig'
```

### tt-change
*tt-change*
```bash
#!/bin/bash
source config.sh; # load the config library functions
source tt-lib.sh;
author="$(config_get author)"

#case of input file is the original file
File=$(basename "$1")
File=$(cleanName "$File")
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

#*ttc}}

if [[ $extens2 == md ]]
then
    #*change meta data with click on text file}}
else
    #*change meta data with click on file}}
fi

```

### change meta data with click on text file

*change meta data with click on text file*
```bash
abfrage=$(yad --title="Enter new filename" --text="Type new filename" \
    --form --width 500 --separator="~" --item-separator=","  \
    --field="Name" \
    --field="Source:":CBE \
    --field="Tags" \
    --field="Something more":TXT \
    "$(basename ${filename2} .$extens3)" "$author,Internet," "" "")
if [ ! $? -eq 1 ];
then
    Newname=$(echo $abfrage | cut -s -d "~" -f 1)
    Newname=$(cleanName "$Newname")
    source=$(echo $abfrage | cut -s -d "~" -f 2)
    tags=$(echo $abfrage | cut -s -d "~" -f 3)
    additiontext=$(echo $abfrage | cut -s -d "~" -f 4)
    mv "$filename2"/"$filename2" "$filename2"/"$Newname"."$extens3"
    mv "$filename2"/"${filename2%.*}" "$filename2"/"$Newname"
    mv "$filename2"/"${filename2%.*}"_files "$filename2"/"$Newname"_files
    mv "$filename2"/"${filename2%.*}"-Dateien "$filename2"/"$Newname"-Dateien
    mv "$filename2"/"${filename2%.*}"_Dateien "$filename2"/"$Newname"_Dateien
    mv "$filename2"/"$filename2".png "$filename2"/"$Newname"."$extens3".png
    mv "$filename2"/"$filename2".avif "$filename2"/"$Newname"."$extens3".avif
    mv "$filename2"/"${filename2%.*}".de.vtt "$filename2"/"$Newname".de.vtt
    mv "$filename2"/"${filename2%.*}".en.vtt "$filename2"/"$Newname".en.vtt
    mv "$filename2"/"${filename2%.*}".ttml "$filename2"/"$Newname".ttml
    mv "$File2" "$Newname"."$extens3".md
    mv "$filename2" "$Newname"."$extens3"
    ttc "$filename2" "$Newname"."$extens3"
    sed -i "3 s/\*\*\[\[../$tags\*\*\[\[../" "$Newname"."$extens3".md
    sed -i "4 s/\*\*\[\[../$tags\*\*\[\[../" "$Newname"."$extens3".md
    sed -i "3 s/\]\]/\]\] ${source}/" "$Newname"."$extens3".md
    sed -i "4 s/\]\]/\]\] ${source}/" "$Newname"."$extens3".md
    sed -i "s/\[\[..\/\]\]/\[\[..\/\]\]\n $additiontext/" "$Newname"."$extens3".md
    echo "$Newname"."$extens3"
fi

```

### change meta data with click on file file

*change meta data with click on file*
```bash
abfrage=$(yad --title="Enter new filename" --text="Type new filename" \
    --form --width 500 --separator="~" --item-separator=","  \
    --field="Name" \
    --field="Source:":CBE \
    --field="Tags" \
    --field="Something more":TXT \
    "$filename" "$author,Internet," "" "")
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
```

### ttc function

using ``ttc`` function with the parameters as following
```bash
    ttc p1 p2
    p1 - old file
    p2 - new target file
```

*ttc*
```bash
function ttc(){
    local oldFile=$(basename "$1")
    local File=$(basename "$2")
    local File=$(cleanName "$File")
    local oldname=${oldFile%.*} #only the filename
    local filename=${File%.*} #only the filename
    local extens=${File##*.}

    sed -i "1 s/$oldFile/$File/" "$File".md
    sed -i "2 s/$oldFile/$File/" "$File".md
    sed -i "3 s/$oldFile/$File/g" "$File".md
    sed -i "4 s/$oldFile/$File/g" "$File".md
    sed -i "5 s/$oldFile/$File/g" "$File".md
    sed -i "6 s/$oldFile/$File/g" "$File".md
    sed -i "s/$oldFile/$File/g" "$File".md
    sed -i "s/$oldname/$filename/g" "$File".md
    if [[ pdf == $extens ]]
    then
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
        sed -i "s/\*$oldFile.en.vtt\*/\*$File.en.vtt\*/g" "$File".md
        sed -i "s/\*$oldFile.de.vtt\*/\*$File.de.vtt\*/g" "$File".md
        sed -i "s/\*$oldFile.ttml\*/\*$File.ttml\*/g" "$File".md
        #Opentxt
    fi
}
```
