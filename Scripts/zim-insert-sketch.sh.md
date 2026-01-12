# zim-insert-sketch
Created [2023:03:02]()

- [x] **zim-insert-sketch**

## documentation

For using ``Krita`` and export in commandline, because ``Krita`` does not save layer information in file.

```bash
krita Vorlage-Notiz.kra --export --export-filename Vorlage-Notiz.avif
```

```bash
cp $templateDir/Vorlage-Notiz.kra "$filename".kra
xterm -e "krita "$filename".kra"
krita "$filename".kra --export --export-filename "$filename".avif

```

## code


*make.sh*
```bash
noweb.py -Rzim-insert-sketch.sh zim-insert-sketch.md > zim-insert-sketch.sh && echo 'fertig'
```

### zim-insert-sketch.sh

*zim-insert-sketch.sh*
```bash
#!/bin/bash
source config.sh; # load the config library functions
source tt-lib.sh;
author="$(config_get author)"

File=$(cleanName "$1")
filetxt=${File%.*}

date=$(date +"%Y-%m-%d--%H-%M-%S")
abfrage=$(yad --title="Insert sketch" --text="Something to add?" \
		--form --width 500 --separator="~" --item-separator=","  \
		--field="Name" \
		--field="Source:":CBE \
		--field="Tags" \
		--field="Something more":TXT \
		"_${date}" "$author,Internet," "" "")

if [ ! $? -eq 1 ];
then
	Newname=$(echo $abfrage | cut -s -d "~" -f 1)
	source=$(echo $abfrage | cut -s -d "~" -f 2)
	tags=$(echo $abfrage | cut -s -d "~" -f 3)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 4)
	if [ ! "$Newname" = "" ];
	then
		filename=$(cleanName "$Newname")
		mkdir -p "$filetxt"
		cd "$filetxt"
		mypaint "$filename".png
		ttpic "$filetxt" "$filename".png "$source" "$tags" "$additiontext" >> "$filetxt"/"$filename".png
		echo -e "[[+${filename}.png]]"
		echo {{./"$filename".png?width=500}}
	fi
fi
```
