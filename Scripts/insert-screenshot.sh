#!/bin/bash
source config.sh; # load the config library functions
source tt-lib.sh;
abfrage=$(yad --title="Inset-Screenshot" --text="Add headline?" \
    --form --separator="~" --item-separator="," \
    --field="Insert Headline:":CB \
    "Yes,No")
headline=$(echo "$abfrage" | cut -s -d "~" -f 1)
Filename="$(basename -z $(wl-paste -n))"
#Filename=$(cleanName $Filename)
if [[ $headline == "Yes" ]];
then
   echo -e "==== $(date +"%Y-%m-%d") "
fi

echo -e "{{./${Filename}?width=500}} "
echo -e "[[+${Filename}]] "

