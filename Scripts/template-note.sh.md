# template-note
Created Dienstag [Zettelkasten:2022:11:01](
- [x] **template-note** [README]()


Create note with a folder

*run-cell.sh*
```bash
noweb.py -Rtemplate-note.sh template-note.sh.md > template-note.sh  && echo 'fertig'
```

```bash
chmod u+x template-note.sh  && ln -sf $(pwd)/template-note.sh ~/.local/bin/template-note.sh && echo 'fertig'
```

*template-note.sh*
```bash
#!/usr/bin/env bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
author="$(config_get author)"
source tt-lib.sh;

if [[ ! -e "$1" ]] 
then
  folder=$(pwd)
  echo $folder
else
  folder=$(basename "$1")
  echo $folder
fi

abfrage=$(yad --title="Note with folder" --text="Something to add?" \
	--form --width 500 --separator="~" --item-separator=","  \
    --field="Name" \
	--field="Tags" \
	--field="Quelle:":CBE \
	--field="Weiteres":TXT \
	"" "" "$author,Internet," "")
if [ ! $? -eq 1 ]; 
then
    name=$(echo $abfrage | cut -s -d "~" -f 1)
	tags=$(echo $abfrage | cut -s -d "~" -f 2)
	source=$(echo $abfrage | cut -s -d "~" -f 3)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 4)

    create-note "${folder}" "${name}" "$tags" "$source" "$additiontext" >> "${folder}"/"${name}".md
fi
```

