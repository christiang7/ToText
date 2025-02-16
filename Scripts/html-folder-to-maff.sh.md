# html-folder-to-maff.sh
Created [2024-02-21](2024-02-21)

- [X] **html-folder-to-maff.sh**
    - [X] Doing
    - [X] Backlog

## Features



## Informations
 Christian Gößl
## Main Program

make script:
    - [x] list all elements of folder with help of the script ttd
    - [x] create files index.dat and index.rdf
    - [x] get file name of html file: "ls -1 | grep "\.html""
    - [x] rename html for to index html
    - [x] name of maff file is "name of html file-number of folder"
    - [x] export content of html file to index.rdf with lynx "lynx -list_inline -dump index.html > index.rdf"
    - [x] make folder to a zip file
    - [x] rename zip file to maff
    - [x] ttn of maff file


*run-cell.sh*
```bash
noweb.py -Rhtml-folder-to-maff.sh html-folder-to-maff.sh.md > html-folder-to-maff.sh && echo 'fertig' 
```

*html-folder-to-maff.sh*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
source tt-lib.sh;

htmlfolder="$1"
list=$(ls -1 "$htmlfolder")
echo $list
lines="$(wc --lines <<< "$list")"
cd $htmlfolder
for (( i=$lines ; i>=1 ; i-- ));
do
	element=$(sed -n "${i}p" <(echo "$list"))
	echo "$element"
	
    #*maff file creation}}
    
    #*description file}}
    
done
```


*maff file creation*
```bash
folder="$element"
folder=$(echo $folder | sed 's/\///g')
echo $folder

#htmlFile=$(ls -1 "$folder" | grep "\.html ")
htmlFile=$(find "$folder" -type f -iname "*.html")
htmlFile=$(basename "$htmlFile")
echo $htmlFile

htmlFileName=$(basename "$htmlFile" .html)
mv "$folder"/"$htmlFile" "$folder"/index.html
touch "$folder"/index.dat "$folder"/index.rdf
lynx -list_inline -dump "$folder"/index.html > "$folder"/index.rdf
maffFileName=$(echo "$htmlFileName-$folder")
####mv "$folder" "$maffFileName"
#zip -r $maffFileName.zip "$maffFileName"
zip -r "$maffFileName".zip "$folder"
mv "$maffFileName".zip "$maffFileName".maff
```


*description file*
```bash
file-description "$(pwd)" "$maffFileName".maff >> "$(pwd)"/"$maffFileName".maff.md
folder2=$(unzip -Z -1 "$maffFileName.maff" '*/')
cat $folder2'index.rdf' >> "$maffFileName".maff.md
```
