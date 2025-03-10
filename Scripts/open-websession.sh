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
    firstcharacters=${text:0:4}
    #echo $firstcharacters
    #echo $lines
    if [[ "$firstcharacters" == "http" ]]
    then
        #echo 'http'
        for (( i=1 ; i<=$lines ; i++ ));
        do
            if (($i % 2 == 1));
            then
                #element="$(echo "${text[0]}" | sed "${i}q;d" | head -n1 | cut -d " " -f1)"
                if [[ $typ == "File" ]]
                then
                    element="$(cat "${text}" | sed "${i}q;d")"
                else
                    #element="$(echo "${text[0]}" | sed "${j}q;d" | head -n1 | cut -d " " -f2)"
                    element="$(echo "${text}" | sed "${i}q;d")"
                fi
                echo "$element"
                #echo "$((($i % 2)))"
                firefox --new-tab "$element"
            fi
        done
    else
        #echo 'no http'
        for (( j=1 ; j<=$lines ; j++ ));
        do
            if (($j % 2 == 0));
            then
                if [[ $typ == "File" ]]
                then
                    element="$(cat "${text}" | sed "${j}q;d")"
                else
                    #element="$(echo "${text[0]}" | sed "${j}q;d" | head -n1 | cut -d " " -f2)"
                    element="$(echo "${text}" | sed "${j}q;d")"
                fi
                #echo "$element"
                #echo ${j}
                firefox --new-tab "$element"
            fi
        done
    fi

fi
