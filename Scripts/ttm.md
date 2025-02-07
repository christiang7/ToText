# ttm
[Zettelkasten:2021:05:03]()

*run-cell.sh*
```bash
noweb.py -Rttm ttm.md > ttm && chmod u+x ttm && echo 'fertig'
```

*ttm*
```bash
#!/usr/bin/env bash
source config.sh; # load the config library functions
journalDir="$(config_get journalDir)"
journalPage="$(config_get journalPage)"
wikiDir="$(config_get wikiDir)"
source tt-lib.sh


f=$(basename "$1")
extens=${f##*.}
name=${f%.*}
folder=$(date +"$journalDir/%Y/%m/%d" -r "$f")
mkdir -p $folder

if [[ $extens == "md" ]]
then
	mv $f "$folder"/$f
	mv "$name" "$folder"/"$name"
else
	abfrage=$(yad --title="Move file to today page?" --text="Something to add?" \
		--form --separator="~" --item-separator="," \
		--field="Name:" \
		--field="Source:" \
		--field="Tags:" \
		--field="Something more:":TXT \
		"$name" "$2" "" "")

	if [ ! $? -eq 1 ];
	then
		Newname=$(echo $abfrage | cut -s -d "~" -f 1)
		source=$(echo $abfrage | cut -s -d "~" -f 2)
		tags=$(echo $abfrage | cut -s -d "~" -f 3)
		additiontext=$(echo $abfrage | cut -s -d "~" -f 4)

		File=$(cleanName "$Newname.$extens")

		mv "$f" "$folder"/"$File"
		cd "$folder"

		tt "$File" "$tags" "$source" "$additiontext" "no"

	fi

fi
```
