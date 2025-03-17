# template-calculation
Created [2023-06-25]()
 math
- [x] **template-calculation** [README.md](README.md)
	- [x] Doing
	- [x] Backlog

## Features



## Informations
Christian Gößl

External Tools
https://docs.kde.org/stable5/en/kate/kate/kate-application-plugin-external-tools.html


## Main Program

*run-cell.sh*
```bash
noweb.py -Rtemplate-calculation.sh template-calculation.md > template-calculation.sh && echo 'template-calculation.sh' && date
```

### Presets

Einstellungen vor dem Start des eigentlichen Programms, hier für ein Shell Script ist diese Zeile notwendig

*preamble*
```bash
#!/bin/bash
source config.sh
source tt-lib.sh
langName="$(config_get langName)"
author="$(config_get author)"
```

### template-calculation.sh

*template-calculation.sh*
```bash
#*preamble}}

typ=$(yad --title="New calculation?" --text="Necessary Informations:" \
	--form --width 500 --separator="" --item-separator=","  \
	--field="Type of calculation":CB \
	"Standalone File,Project")
if [ ! $? -eq 1 ];
then
	if [[ ! -e "$1" ]]
	then
		folder=$(pwd)
		#echo $folder
	else
		filetxt=$(readlink -f -n "$1")
		folder=${filetxt%.*}
		#echo $folder
		mkdir -p "$folder"
	fi
	case ${typ} in
	"Standalone File")
		File="Filename"

		#*requests}}

		;;
	Project)
		template-calculation-project.sh "$1"
		;;
	esac
fi
```


### requests

*requests*
```bash
abfrage=$(yad --title="New calculation?" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Filename" \
	--field="Shortname for language":CBE \
	--field="Author":CBE \
	--field="Tags":CBE \
	--field="Description":TXT \
	"$File" "$langName" "$author,Internet" ",physic,math" "$additiontext")
if [ ! $? -eq 1 ];
then
	File=$(echo $abfrage | cut -s -d "~" -f 1)
	langname=$(echo $abfrage | cut -s -d "~" -f 2)
	source=$(echo $abfrage | cut -s -d "~" -f 3)
	tags=$(echo $abfrage | cut -s -d "~" -f 4)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 5)
	File=$(cleanName "$File")

	extens="$(get-extens ${langname})"

	Filename="$File"
	File="$File"."${extens}"

	#*create Template}}

fi
```

### create template

Creating template


*create Template*
```bash

markdown-description-program "${Filename}.${extens}" >> "$folder"/"${Filename}.${extens}".md

template-code "$folder" "${Filename}.${extens}" >> "$folder"/"${Filename}.${extens}".md

```

