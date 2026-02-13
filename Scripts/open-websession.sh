#!/bin/bash
typ=$(yad --title="Open links?"  \
	--form --width 500 --separator="" --item-separator=","  \
	--field="Source":CB \
	"File,Copied")
if [ ! $? -eq 1 ];
then
    #text="$(xclip -o)"
    if [[ $typ == "File" ]]
    then
        #text="$(cat $1)"
        text="$1"
        lines="$(wc --lines <<< "$(cat ${text})")"
    else
        text="$(wl-paste -n)"
        lines="$(wc --lines <<< "${text}")"
    fi
    #echo $text
    element=""
    for (( i=1 ; i<=$lines ; i++ ));
    do
        if [[ $typ == "File" ]]
        then
            element="$(cat "${text}" | sed "${i}q;d")"
        else
            #element="$(echo "${text[0]}" | sed "${j}q;d" | head -n1 | cut -d " " -f2)"
            element="$(echo "${text}" | sed "${i}q;d")"
        fi
        #echo "$element"
        if [[ "${element:0:4}" == "http" ]]
        then
            firefox --new-tab "$element"
        fi
    done
fi
