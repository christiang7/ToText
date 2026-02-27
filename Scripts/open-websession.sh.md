# open-websession
Created Sonntag [2022:10:16]()

- [x] **open-websession**

bash list output first line element - Ecosia - Web  
https://www.ecosia.org/search?q=bash%20list%20output%20first%20line%20element&addon=firefox&addonversion=4.1.0&method=topbare  
syntax - In bash, how can I print the first n elements of a list? - Stack Overflow  
https://stackoverflow.com/questions/885620/in-bash-how-can-i-print-the-first-n-elements-of-a-liste  
bash: Assigning the first line of a variable to a variable - Unix & Linux Stack Exchange  
https://unix.stackexchange.com/questions/205022/bash-assigning-the-first-line-of-a-variable-to-a-variable  
get first element of string bash - Ecosia - Web  
https://www.ecosia.org/search?q=get%20first%20element%20of%20string%20bash&addon=firefox&addonversion=4.1.0&method=topbar  
bash - How to get the first word of a string? - Unix & Linux Stack Exchange  
https://unix.stackexchange.com/questions/65932/how-to-get-the-first-word-of-a-string  
shell - Bash tool to get nth line from a file - Stack Overflow  
https://stackoverflow.com/questions/6022384/bash-tool-to-get-nth-line-from-a-file  
arrays - bash + for loop + output index number and element - Stack Overflow  
https://stackoverflow.com/questions/38602587/bash-for-loop-output-index-number-and-element  
How to preserve line breaks when storing command output to a variable? [duplicate] | AnonymousOverflow  
https://ao.bloat.cat/questions/22101778/how-to-preserve-line-breaks-when-storing-command-output-to-a-variable  

``STRINGTEST="clipboard content"``
``echo "${STRINGTEST[0]}" | sed '5q;d' | head -n1 | cut -d " " -f1``

*make.sh*
```bash
noweb.py -Ropen-websession.sh open-websession.sh.md > open-websession.sh && date && notify-send -a "Compilation of open-websession.sh" "" "$(date +"%Y-%m-%d") fertig"
```


```bash
chmod u+x open-websession.sh && ln -sf $(pwd)/open-websession.sh ~/.local/bin/open-websession.sh && echo 'fertig'
```

### open-websession
*open-websession.sh*
```bash
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
    notify-send -a "Websession opened" "" "$(date +"%Y-%m-%d") fertig"
fi
```

