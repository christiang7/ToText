# zim-firefox-session
Created Sonntag [Zettelkasten:2022:10:16]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **zim-firefox-session**


<https://www.ecosia.org/search?q=bash%20list%20output%20first%20line%20element&addon=firefox&addonversion=4.1.0&method=topbar> | bash list output first line element - Ecosia - Web
<https://stackoverflow.com/questions/885620/in-bash-how-can-i-print-the-first-n-elements-of-a-list> | syntax - In bash, how can I print the first n elements of a list? - Stack Overflow
<https://unix.stackexchange.com/questions/205022/bash-assigning-the-first-line-of-a-variable-to-a-variable> | bash: Assigning the first line of a variable to a variable - Unix & Linux Stack Exchange
<https://www.ecosia.org/search?q=get%20first%20element%20of%20string%20bash&addon=firefox&addonversion=4.1.0&method=topbar> | get first element of string bash - Ecosia - Web
<https://unix.stackexchange.com/questions/65932/how-to-get-the-first-word-of-a-string> | bash - How to get the first word of a string? - Unix & Linux Stack Exchange
<https://stackoverflow.com/questions/6022384/bash-tool-to-get-nth-line-from-a-file> | shell - Bash tool to get nth line from a file - Stack Overflow
<https://stackoverflow.com/questions/38602587/bash-for-loop-output-index-number-and-element> | arrays - bash + for loop + output index number and element - Stack Overflow

``STRINGTEST="clipboard content"``
``echo "${STRINGTEST[0]}" | sed '5q;d' | head -n1 | cut -d " " -f1``

*run-cell.sh*
```bash
noweb.py -Rzim-firefox-session.sh zim-firefox-session.md > zim-firefox-session.sh
```
```bash
chmod u+x zim-firefox-session.sh && ln -sf $(pwd)/zim-firefox-session.sh ~/.local/bin/zim-firefox-session.sh && echo 'fertig'
```

*zim-firefox-session.sh*
```bash
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
```

