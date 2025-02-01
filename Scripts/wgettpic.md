# wgettpic
Created Donnerstag [Zettelkasten:2021:04:29]()
- [X] **wgettpic** [README](README.md)


[wget-download-firefox](./wget-download-firefox.md)

*run-cell.sh*
```bash
noweb.py -Rwgettpic wgettpic.md > wgettpic && chmod u+x wgettpic && echo 'fertig'
```

*wgettpic*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalDir="$(config_get journalDir)"
source tt-lib.sh;

Orig=$(basename "$1")
f=$(basename "$Orig")
origname=${Orig%.*} #only the filename
extens=${Orig##*.}
Newname=${Orig%.*}

abfrage=$(yad --title="Download Picture" --text="Noch etwas hinzufügen?" \
    --form --separator="~" --item-separator="," \
    --field="Anderer Name:" \
    --field="Quelle:" \
    --field="Tags:" \
    --field="Weiteres:":TXT \
    "$Newname" "$1" "" "")

if [ ! $? -eq 1 ];
then

    Newname=$(echo $abfrage | cut -s -d "~" -f 1)
    source=$(echo $abfrage | cut -s -d "~" -f 2)
    tags=$(echo $abfrage | cut -s -d "~" -f 3)
    additiontext=$(echo "$abfrage" | cut -s -d "~" -f 4)

    folder=$(date +"$journalDir/%Y/%m/%d")
    mkdir -p $folder
    cd $folder
    File=$(wget --no-use-server-timestamps --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" --no-check-certificate "$1" 2>&1 | tee /dev/tty | grep gespeichert | cut -d ' ' -f 3 | sed -e 's/[^A-Za-z0-9._-]//g')


    if [ "$Newname" == ""  ];
    then
        Newname=$(echo "$origname")
    fi
    File=$(cleanName "$Newname.$extens" )

    mv "$f" "$File"

    convert "$File" "$Newname".avif
    rm "$File"

    ttpic "$folder" "${Newname}.avif" "$tags" "$source" "$additiontext"

fi
```



