# ttpdf
Text date: [Zettelkasten:2021:04:29]() Modi date: [Zettelkasten:2021:04:22]()
- [X] ttpdf [README](README.md)


```bash
{{run-cell.sh}}=
noweb.py -Rttpdf ttpdf.md > ttpdf && chmod u+x ttpdf && echo 'fertig'
@
```


```bash
{{ttpdf}}=
#!/bin/bash
f=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
File=$(basename "$f")
{{pdf with folder}}
@
```

```bash
{{pdf with folder}}=
folder=$(basename "$File" .pdf)
echo $folder
mkdir "$folder"
mv "$File" "$folder"/"$File"
mv "$folder" "$folder.pdf"
folder="$folder.pdf"
touch "$File".md
echo "Content-Type: text/x-zim-wiki" >> "$File".md
echo "Wiki-Format: zim 0.6" >> "$File".md
echo "# [[./$File]]" >> "$File".md
echo "Text date: $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]") Modi date: $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]" -r "$folder"/"$File")" >> "$File".md
echo "@ARTIKEL $3 " >> "$File".md
echo -e "$2\n$4\n" >> "$File".md
pdftoppm -png -singlefile "$folder"/"$File" "$folder"/"$File"
convert "$folder"/"$File".png -resize 800x800 "$folder"/"$File".avif
rm "$folder"/"$File".png
echo -e "{{./$File.avif?width=500}}\n" >> "$File".md
pdfinfo "$folder"/"$File" | grep Pages >> "$File".md
echo -e "\n" >> "$File".md
pdftotext -nopgbrk -enc UTF-8 -f 1 -l 1 "$folder"/"$File" ->> "$File".md
@
```

```Bash
{{pdf without folder}}=
touch "$File".md
echo "Content-Type: text/x-zim-wiki" >> "$File".md
echo "Wiki-Format: zim 0.6" >> "$File".md
#echo "====== $f ======" >> "$File".md
echo "# $f" >> "$File".md
echo "Text date: $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]") Modi date: $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]" -r "$1")" >> "$File".md
echo "@ARTIKEL $3 " >> "$File".md
#echo "- [X] **[[../$f]] **" >> "$File".md
#echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]" -r "$1")" >> "$File".md
echo -e "$2\n$4\n" >> "$File".md
#pdftoppm -r 90 -png -singlefile "$File" "$File"
pdftoppm -png -singlefile "$File" "$File"
#convert "$File".png -resize 1200x1200 -quality 97 "$File"-px.png
#mv "$File"-px.png "$File".png
convert "$File".png -resize 800x800 "$File".avif
rm "$File".png
#echo -e "{{../$f.png?width=500}}\n" >> "$File".md
echo -e "{{../$f.avif?width=500}}\n" >> "$File".md
pdfinfo "$f" | grep Pages >> "$File".md
echo -e "\n" >> "$File".md
pdftotext -nopgbrk -enc UTF-8 -f 1 -l 1 "$f" ->> "$File".md
#kate "$File".md 2>/dev/null &
#okular "$1" 2>/dev/null &
#sleep 10
@
```


