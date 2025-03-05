# ttd
[2021:04:22]()
- [x] **[../ttd](./ttd)**
Create for all files in a folder text files automaticly.

*run-cell.sh*
```bash
noweb.py -Rttd ttd.md > ttd && chmod u+x ttd && echo 'fertig'
```

*ttd*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
source tt-lib.sh;
yad --title="Execute ttd?" --text="\n All files in folder will get description files\n"
if [ ! $? -eq 1 ];
then
	folder=$(basename "$1" .md)
	mkdir -p $folder
	folder=$(echo $folder | sed 's/\///g')
	list=$(ls -1 --hide=*.md "$folder")
	lines="$(wc --lines <<< "$list")"

	cd "$folder"
	for (( i=$lines ; i>=1 ; i-- )); 
	do
		element=$(sed -n "${i}p" <(echo "$list"))

		if [ ! -e "$File".md ];
		then
			tt "$element" "" "" "" "no"
		fi
	done
fi
```
