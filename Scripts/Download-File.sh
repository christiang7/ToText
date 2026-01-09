#!/bin/bash
source config.sh; # load the config library functions
#journalDir="$(config_get journalDir)"
source tt-lib.sh;

url="$(wl-paste -n)"
Orig=$(basename "$url")
origname=${Orig%.*} #only the filename
extens=${Orig##*.}

foldertxt="$1"
folder="${foldertxt%.*}"
if [ "$folder" == ""  ];
then
    folder=$(pwd)
fi
mkdir -p $folder
cd $folder

#origname=$(echo $origname | cut -s -d "?" -f 0)

abfrage=$(yad --title="Download File" --text="Something to add?" \
    --form --separator="~" --item-separator="," \
    --field="Another name:" \
    --field="Source:" \
    --field="Tags:" \
    --field="Something more:":TXT \
    --field="Insert Headline:":CB \
    "$origname" "$url" "" "" "Yes,No")

if [ ! $? -eq 1 ];
then
    Newname=$(echo $abfrage | cut -s -d "~" -f 1)
    source=$(echo $abfrage | cut -s -d "~" -f 2)
    tags=$(echo $abfrage | cut -s -d "~" -f 3)
    additiontext=$(echo "$abfrage" | cut -s -d "~" -f 4)
    headline=$(echo "$abfrage" | cut -s -d "~" -f 5)

    #echo $Newname

    File=$(wget --no-use-server-timestamps --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" --no-check-certificate --inet4-only "$url" 2>&1 | tee /dev/tty | grep Wird | cut -d ' ' -f 3 | sed "s/‘//g" | sed "s/’//g")
    #echo $File
    extens=$(file -b --extension "$File" | cut -d / -f 1)
    if [ "$Newname" == ""  ];
    then
        Newname="$origname"
    else
        Newname="$(cleanName "$Newname")"
    fi
    #echo $Newname
    mv "$File" "$Newname".$extens
    File="$Newname".$extens

    tt "${File}" "$tags" "$source" "$additiontext" "no"
    if [[ $headline == "Yes" ]];
    then
        echo -e "==== $(date +"%Y-%m-%d") "
    fi
    if [[ jpg == $extens || PNG == $extens || JPEG == $extens || png == $extens || webp == $extens || jpeg == $extens || avif == $extens ]]
	then
        extens="avif"
        echo -e "{{./$Newname.$extens?width=500}}"
	fi
    echo "[[+$Newname.$extens]]"
fi
