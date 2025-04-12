# zim-xournal
Created Mittwoch [2022:06:29]()

- [x] **zim-xournal**


## Features
- Abfrage vom Dateinamen siehe [ttrename](./ttrename.md)
- export automatisch die pdf Datei nach schließen der Datei 


## Code

*make.sh*
```bash
noweb.py -Rzim-xournal.sh zim-xournal.md > zim-xournal.sh && echo 'fertig'
```


### zim-xournal.sh
*zim-xournal.sh*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
source tt-lib.sh;
author="$(config_get author)"

File=$1
par=$2
if [[ $par == "" ]];
then
    par="Note"
fi
filepath=${File%.*}
foldername=$(basename "$File" .md)
File=$(cleanName "$foldername")
name="${par}-$(date +%Y-%m-%d)-$File"
abfrage=$(yad --title="Zim xournalpp note" --text="Type new filename" \
	--form --width 500 --separator="~" --item-separator=","  \
    --field="Name" \
	--field="Tags" \
	--field="Quelle:":CBE \
	--field="Weiteres":TXT \
	"${name}" "" "$author,Internet," "")

if [ ! $? -eq 1 ];
then
    name=$(echo $abfrage | cut -s -d "~" -f 1)
	tags=$(echo $abfrage | cut -s -d "~" -f 2)
	source=$(echo $abfrage | cut -s -d "~" -f 3)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 4)

    mkdir -p "$foldername"
    cd "$foldername"
    filename=$(cleanName "$name")
    File=$(echo "$filename".xopp)
    xournalpp "$filename".xopp && xournalpp "$File" -p "$filename".pdf
    if [ "Unterrichtsnotiz" != "$par" ];
    then
        file-description "$(pwd)" "$File" "@Document $tags" "$source" "$additiontext" >> "$(pwd)"/"$File".md
    fi
fi
```

