# zim-treesheets
Created Freitag [Zettelkasten:2022:10:07]()
Backlink [CodeFabrik:GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **zim-treesheets**  >  2277-11-11


  ``noweb.py -Rzim-treesheets.sh zim-treesheets.md > zim-treesheets.sh && chmod u+x zim-treesheets.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/ZetteL/CodeFabrik/GedankenspeicherCoding/zim-treesheets.sh ~/.local/bin/zim-treesheets.sh && echo 'fertig'``

exportierte Bilder wieder in die Textdatei einfügen mittels ocr

``tesseract -l eng+deu 2209.14792.pdf.png stdout``

```bash
{{zim-treesheets.sh}}=
#!/bin/bash
if zenity --question --text="Möchten Sie Treesheets öffnen?"
then 
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
filetxt=${File%.*}
mkdir -p "$filetxt"
cd "$filetxt"
filetxtname=$(basename "$File" .txt)
filedate=$(date +"%Y-%m-%d")
if [[ $2 == Notiz ]]
then
	additontext="$2"
else
	additontext="$2-$filetxtname"
fi
Newname=$(zenity --entry \
       --width 500 \
       --title "Type new filename" \
       --text "Enter new filename" \
       --entry-text "$filedate-$additontext")
filename=$(echo "$Newname" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
cp ~/Gedankenspeicher/Vorlagen/Vorlage-10-10.cts "$filename".cts
cp ~/Gedankenspeicher/Vorlagen/Vorlage-10-10.png "$filename".cts.png
treesheets "$filename".cts && ttn "$filename".cts
fi
@
```

