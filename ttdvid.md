# ttdvid

- [X] **ttdvid**

Created Sonntag [Zettelkasten:2021:05:23]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

*run-cell.sh*
```bash
noweb.py -Rttdvid ttdvid.md > ttdvid && chmod u+x ttdvid && echo 'fertig'
```

*ttdvid*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalDir="$(config_get journalDir)"

ls --hide=*.md --hide=*.srt --hide=*.ttml "$1" > f
while read f
do
	echo $(date +"$journalDir/%Y/%m/%d.md" -r "$1"/"$f")
	File=$(date +"$journalDir/%Y/%m/%d.md" -r "$1"/"$f")
	g=$(basename "$1"/"$f")
	touch "$File"
	echo -e "\n" >> "$File"
	echo [ ] >2277-11-11 @VIDEO @VIDEOARCHIV "$2" "$g" >> "$File"
done < f
rm f
```
