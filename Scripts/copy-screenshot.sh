#!/bin/bash
source config.sh; # load the config library functions
source tt-lib.sh;
abfrage=$(yad --title="Inset-Screenshot" --text="Add headline?" \
    --form --separator="~" --item-separator="," \
    --field="- Insert Headline":CHK \
    "TRUE")
headline=$(echo "$abfrage" | cut -s -d "~" -f 1)
Filename=$(basename "$1")
#Filename=$(cleanName $Filename)
if [[ $headline == TRUE ]];
then
   echo -e "==== $(date +"%Y-%m-%d")" > COPY
fi

echo -e "{{./${Filename}?width=500}}" >> COPY
echo -e "[[+${Filename}]]" >> COPY
wl-copy "$(cat COPY)"
rm COPY
notify-send -a "Screenshot copied" "" "$(date +"%Y-%m-%d") fertig"
