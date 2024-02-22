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

```bash
noweb.py -Rhtml-folder-to-maff.sh html-folder-to-maff.sh.md > html-folder-to-maff.sh && echo 'fertig' 
```


```bash
chmod u+x html-folder-to-maff.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/Gedankenspeicher-Coding/html-folder-to-maff.sh ~/.local/bin/html-folder-to-maff.sh && echo 'fertig'
 ```

```bash
{{html-folder-to-maff.sh}}=
#!/bin/bash
htmlfolder="$1"
list=$(ls -1 "$htmlfolder")
echo $list
lines="$(wc --lines <<< "$list")"
cd $htmlfolder
for (( i=$lines ; i>=1 ; i-- ));
do
	element=$(sed -n "${i}p" <(echo "$list"))
	echo "$element"
    {{maff file creation}}
    {{description file}}
done
@
```


```bash
{{maff file creation}}=
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
#ttn $maffFileName.maff
@
```


```bash
{{description file}}=
echo "Content-Type: text/x-zim-wiki" >> "$maffFileName".md
echo "Wiki-Format: zim 0.6" >> "$maffFileName".md
echo "====== $maffFileName.maff ======" >> "$maffFileName".md
echo "Text date: $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]") File date: $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]" -r "$maffFileName".maff)" >> "$maffFileName".md
folder2=$(unzip -Z -1 "$maffFileName.maff" '*/')
echo "[*] **[[../$maffFileName.maff]]**" >> "$maffFileName".md
cat $folder2'index.rdf' >> "$maffFileName".md
@
```
