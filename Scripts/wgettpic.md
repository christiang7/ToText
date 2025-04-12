# wgettpic
Created Donnerstag [2021:04:29]()


*make.sh*
```bash
noweb.py -Rwgettpic wgettpic.md > wgettpic && chmod u+x wgettpic && echo 'fertig'
```

### wgettpic

*wgettpic*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalDir="$(config_get journalDir)"
source tt-lib.sh;

url="$1"
Orig=$(basename "$url")
origname=${Orig%.*} #only the filename
extens=${Orig##*.}

abfrage=$(yad --title="Download Picture" --text="Sonething to add?" \
    --form --separator="~" --item-separator="," \
    --field="Another name:" \
    --field="Source:" \
    --field="Tags:" \
    --field="Something more:":TXT \
    "$origname" "$1" "" "")

if [ ! $? -eq 1 ];
then

    Newname=$(echo $abfrage | cut -s -d "~" -f 1)
    source=$(echo $abfrage | cut -s -d "~" -f 2)
    tags=$(echo $abfrage | cut -s -d "~" -f 3)
    additiontext=$(echo "$abfrage" | cut -s -d "~" -f 4)

    folder=$(date +"$journalDir/%Y/%m/%d")
    mkdir -p $folder
    cd $folder

    File=$(wget --no-use-server-timestamps --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" --no-check-certificate "$url" 2>&1 | tee /dev/tty | grep gespeichert | cut -d ' ' -f 3 | sed -e 's/[^A-Za-z0-9._-]//g')


    if [ "$Newname" == ""  ];
    then
        Newname=$origname
    fi
    File="$Newname".$extens

    tt "${File}" "$tags" "$source" "$additiontext" "no"

fi
```



