#!/bin/bash
yad --title="Open links in firefox?" --text="\n All selected links will be send to firefox\n"
if [ ! $? -eq 1 ];
then
    #text="$(xclip -o)"
    text="$(wl-paste -n)"
    #echo $text
    element=""
    lines="$(wc --lines <<< "$text")"
    firstcharacters=${text:0:4}
    #echo $firstcharacters
    #echo $lines
    if [ "$firstcharacters" = "http" ];
    then
        #echo 'http'
        for (( i=1 ; i<=$lines ; i++ ));
        do
            #element+=" $(echo "${text[0]}" | sed "${i}q;d" | head -n1 | cut -d " " -f1)"
            element=" $(echo "${text[0]}" | sed "${i}q;d" | head -n1 | cut -d " " -f1)"
            #echo "$element"
            #echo ${i}
            firefox --new-tab "$element"
        done
        #echo "firefox $element"
        #firefox --new-tab "$element"
    else
        #echo 'no http'
        for (( j=1 ; j<=$lines ; j++ ));
        do
            if (($j % 2 == 0));
            then
            #element+=" $(echo "${text[0]}" | sed "${i}q;d" | head -n1 | cut -d " " -f1)"
            element=" $(echo "${text[0]}" | sed "${j}q;d" | head -n1 | cut -d " " -f2)"
            echo "$element"
            #echo ${j}
            firefox --new-tab "$element"
            fi
        done
    fi

fi
