#!/bin/bash
source tt-lib.sh; # load the config library functions
abfrage=$(yad --title="Inset-Screenshot" --text="Add headline?" \
    --form --separator="~" --item-separator="," \
    --field="Insert Headline:":CB \
    "Yes,No")
if [ ! $? -eq 1 ];
then
    headline=$(echo "$abfrage" | cut -s -d "~" -f 1)
    Filename="$(basename -z $(wl-paste -n))"
    #Filename=$(cleanName $Filename)
    if [[ $headline == "Yes" ]];
    then
    echo -e "==== $(date +"%Y-%m-%d") "
    fi

    echo -e "{{./${Filename}?width=500}} "
    echo -e "[[+${Filename}]] "
fi
