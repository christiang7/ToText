# zim-quotes-copy
Created [[2023-06-21]]

- [X]  **zim-quotes-copy**  [README.md](README.md)
    - [X] Doing
    - [X] Backlog

## Features

Works in X11 and Wayland.

Quoting with Anchors and Links. The quoted text ist formated as verbatim text.

```bash
noweb.py -Rzim-quotes-copy.sh zim-quotes-copy.md > zim-quotes-copy.sh && echo 'fertig'
```

```bash
chmod u+x zim-quotes-copy.sh && ln -sf /home/christian/Gedankenspeicher/KanDo/GedankenspeicherEinrichtung/GedankenspeicherCoding/zim-quotes-copy.sh ~/.local/bin/zim-quotes-copy.sh && echo 'fertig'
```

*zim-quotes-copy.sh*
```bash
#!/bin/bash
file=$(readlink -f -n "$1")
text=$(echo "$2")
filepath=$(echo "${file%/*}" | sed "s,/home/christian,~,")
wikipath=$(echo $filepath | sed "s,~/Gedankenspeicher/Gedankenspeicherwiki/,," | sed "s,/,:,g")
FullFilename=$(basename $file .md)
PageName=$(echo "$FullFilename" | sed 's/_/ /g')
dateID=$(date +"date%Y%m%d%H%M%S")
outputText="== [[$wikipath:$FullFilename\#$dateID|Zitat der Seite: $PageName]] ==\n ''$text''\n Vom $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")"
echo -n -e "**__ $text (Zitat {{id: $dateID}})__**"
wlexecution=$(echo -e $outputText | wl-copy -n &)
sleep 1
killall wl-copy
exit
```
