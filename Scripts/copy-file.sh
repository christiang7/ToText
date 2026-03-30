#!/bin/bash
source config.sh; # load the config library functions
source tt-lib.sh;
abfrage=$(yad --title="Copy-File" --text="Add headline?" \
    --form --separator="~" --item-separator="," \
    --field="- Insert Headline":CHK \
    "TRUE")
headline=$(echo "$abfrage" | cut -s -d "~" -f 1)
File=$(basename "$1" .md)
extens=${File##*.}
Filename=${File%.*}
#Filename=$(cleanName $Filename)
if [[ $headline == TRUE ]];
then
   echo -e "==== $(date +"%Y-%m-%d")" > COPY
fi
if [[ jpg == $extens || PNG == $extens || JPEG == $extens || png == $extens || webp == $extens || jpeg == $extens || avif == $extens ]]
then
    echo -e "{{./${File}?width=500}}" >> COPY
fi
echo -e "[[+${File}]]" >> COPY
wl-copy "$(cat COPY)"
rm COPY
notify-send -a "File copied" "" "$(date +"%Y-%m-%d") fertig"
