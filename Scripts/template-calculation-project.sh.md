# zim-template-calculation
Created [2023-06-25]()
math
- [X] **zim-template-calculation** [README.md](README.md)
    - [X] Doing
    - [X] Backlog

## Features



## Informations
 Christian Gößl


## Main Program

*run-cell.sh*
```bash
noweb.py -Rzim-template-calculation.sh zim-template-calculation.md > zim-template-calculation.sh && echo 'fertig'
```


```bash
chmod u+x zim-template-calculation.sh && ln -sf $(pwd)/zim-template-calculation.sh ~/.local/bin/zim-template-calculation.sh && echo 'fertig'
 ```



*zim-template-calculation.sh*
```bash
#*preamble}}

#*check files}}

#*request}}

```

### Preamble

Einstellungen vor dem Start des eigentlichen Programms, hier für ein Shell Script ist diese Zeile notwendig

*preamble*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
langName="$(config_get langName)"
source tt-lib.sh
```

### Check files

Den Ordner erstellen, wo die neue Datei gespeichert werden soll. Dabei wird der Pfad der Datei genommen und für die späteren Links gespeichert

*check files*
```bash
if [[ -e "$1" ]]
then
    filetxt=$(readlink -f -n "$1")
    folder=${filetxt%.*}
    #Project=$(basename $folder)
else
    #Project="Projectname"
    folder=$(pwd)
fi
#echo $folder
File="Filename"
Project="Projectname"
```

### Request and main program

*request*
```bash
abfrage=$(yad --title="New Project calculation" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Projectname" \
	--field="Filename" \
	--field="Shortname for language":CB \
	--field="Author":CBE \
	--field="Tags":CBE \
	--field="Description":TXT \
	"$Project" "$File" "$langName" "Christian Gößl,Internet" ",physic,math" "$additiontext")
if [ ! $? -eq 1 ];
then
	Project=$(echo $abfrage | cut -s -d "~" -f 1)
	File=$(echo $abfrage | cut -s -d "~" -f 2)
	langname=$(echo $abfrage | cut -s -d "~" -f 3)
	source=$(echo $abfrage | cut -s -d "~" -f 4)
	tags=$(echo $abfrage | cut -s -d "~" -f 5)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 6)
	File=$(cleanName "$File")
    ProjectName="$Project"
    Project=$(cleanName "$Project")

    extens="$(get-extens ${langname})"

    Filename="$File"
    File="$File"."${extens}"

	mkdir -p "$Project"

	create-note "$folder" "$Project" "$tags" "$source" "$additiontext"

	markdown-description-program "$folder/$Project" "README"

	markdown-description-program "$folder/$Project" "${File}"

	program-template "$folder/$Project" "${File}"

    #*git init}}

fi
```

### git versioning

*git init*
```bash
cd "$folder/$Project"
git init
git add README.md
git add "${File}".md
git add ${Filename}.${extens}
git commit -a -m "init git"
```

