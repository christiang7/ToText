# ttne
Created Dienstag [Zettelkasten:2022:11:01](
- [X] **ttne** [README]()


einen Zim Ordner mit txt Datei erstellen lassen irgendwo im Dateisystem

*run-cell.sh*
```bash
noweb.py -Rttne.sh ttne.md > ttne.sh  && echo 'fertig'
```

 ```bash
chmod u+x ttne.sh  && ln -sf $(pwd)/ttne.sh ~/.local/bin/ttne.sh && echo 'fertig'
  ```

*ttne.sh*
```bash
#!/usr/bin/env bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
source tt-lib.sh;

if [[ ! -e "$1" ]] 
then
  folder=$(pwd)
  echo $folder
else
  folder=$(echo "$1")
  echo $folder
fi

abfrage=$(yad --title="Note with folder" --text="Something to add?" \
	--form --width 500 --separator="~" --item-separator=","  \
    --field="Name" \
	--field="Tags" \
	--field="Quelle:":CBE \
	--field="Weiteres":TXT \
	"" "" "Christian Gößl,Internet," "")
if [ ! $? -eq 1 ]; 
then
    name=$(echo $abfrage | cut -s -d "~" -f 1)
	tags=$(echo $abfrage | cut -s -d "~" -f 2)
	source=$(echo $abfrage | cut -s -d "~" -f 3)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 4)

    create-note "${folder}" "${name}" "$tags" "$source" "$additiontext"
fi
```

