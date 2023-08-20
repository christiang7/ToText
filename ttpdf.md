# ttpdf
Text date: [Zettelkasten:2021:04:29]() Modi date: [Zettelkasten:2021:04:22]()
- [X] ttpdf [README](README.md)


  ```bash
noweb.py -Rttpdf ttpdf.md > ttpdf && chmod u+x ttpdf && echo 'fertig'
```


```bash
{{ttpdf}}=
#!/bin/bash
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
f=$(basename "$File")
touch "$File".md
echo "Content-Type: text/x-zim-wiki" >> "$File".md
echo "Wiki-Format: zim 0.6" >> "$File".md
echo "====== $f ======" >> "$File".md
echo "Text date: $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]") Modi date: $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]" -r "$1")" >> "$File".md
echo "[*] @ARTIKEL $3 **[[../$f]]  $2**" >> "$File".md
#echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]" -r "$1")" >> "$File".md
echo -e "\n$4\n" >> "$File".md
#pdftoppm -r 90 -png -singlefile "$File" "$File"
pdftoppm -png -singlefile "$File" "$File"
#convert "$File".png -resize 1200x1200 -quality 97 "$File"-px.png
#mv "$File"-px.png "$File".png
convert "$File".png -resize 4000x4000 "$File".avif
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




