# zim-treesheets
Created Freitag [Zettelkasten:2022:10:07]()
Backlink [CodeFabrik:GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **zim-treesheets**

*run-cell.sh*
```bash
noweb.py -Rzim-treesheets.sh zim-treesheets.md > zim-treesheets.sh && echo 'fertig'
```

```bash
chmod u+x zim-treesheets.sh && ln -sf $(pwd)/zim-treesheets.sh ~/.local/bin/zim-treesheets.sh && echo 'fertig'
```

exportierte Bilder wieder in die Textdatei einfügen mittels ocr

``tesseract -l eng+deu 2209.14792.pdf.png stdout``

*zim-treesheets.sh*
```bash
#!/bin/bash
source config.sh; # load the config library functions
templateDir="$(config_get templateDir)"
source tt-lib.sh

yad --title="Open treesheets?" --text="\n Open treesheets\n"
if [ ! $? -eq 1 ];
then
  File=$(cleanName "$1")
  filetxt=${File%.*}
  mkdir -p "$filetxt"
  cd "$filetxt"
  filetxtname=$(basename "$File" .md)
  filedate=$(date +"%Y-%m-%d")
  if [[ $2 == Notiz ]]
  then
      additontext="$2"
  else
      additontext="$2-$filetxtname"
  fi
  abfrage=$(yad --title="Enter new filename" --text="Type new filename" \
		--form --width 500 --separator="~" --item-separator=","  \
		--field="Name" \
		"$filedate-$additontext")
  if [ ! $? -eq 1 ];
  then
      filename=$(echo $abfrage | cut -s -d "~" -f 1)
      filename=$(cleanName "$filename")
      if [ ! "$filename" = "" ];
      then
        cp $templateDir/Vorlage-10-10.cts "$filename".cts
        cp $templateDir/Vorlagen/Vorlage-10-10.png "$filename".cts.png
        treesheets "$filename".cts && tt "$filename".cts
      fi
  fi
fi
```

