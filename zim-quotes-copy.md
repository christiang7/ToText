# zim-quotes-copy
Created [[2023-06-21]]

- [X]  **zim-quotes-copy**  [README.md](README.md)
    - [X] Doing
        - [ ] insert anchor in the quoted page
            - [ ] set anchor to the link in the pasted page
            - [ ] can be inserted with {{id: anchorname}} and request with yad program for anchor name or yust use the time
    - [X] Backlog
        - [ ] Quoting with verbatim environment in zim
            - [ ] text needs to be formated

## Features

Works in X11 and Wayland.

```bash
noweb.py -Rzim-quotes-copy.sh zim-quotes-copy.md > zim-quotes-copy.sh && echo 'fertig'
```


```bash
chmod u+x zim-quotes-copy.sh && ln -sf /home/christian/Gedankenspeicher/KanDo/GedankenspeicherEinrichtung/GedankenspeicherCoding/zim-quotes-copy.sh ~/.local/bin/zim-quotes-copy.sh && echo 'fertig'
```

```bash
{{zim-quotes-copy.sh}}=
#!/bin/bash
file=$(readlink -f -n "$1")
text=$(echo "$2")
filepath=$(echo "${file%/*}" | sed "s,/home/christian,~,")
wikipath=$(echo $filepath | sed "s,~/Gedankenspeicher/Gedankenspeicherwiki/,," | sed "s,/,:,g")
FullFilename=$(basename $file .md)
PageName=$(echo "$FullFilename" | sed 's/_/ /g')
dateID=$(date +"date%Y%m%d%H%M%S")
outputText="== [[$wikipath:$FullFilename\#$dateID|Zitat der Seite: $PageName]] ==\n $text\n Vom $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")"
echo -n -e "$text {{id: $dateID}}"
#xclip -selection c "$(echo -e "== [[$wikipath:$FullFilename\#$dateID|Zitat der Seite: $PageName]] ==\n $text\n Vom $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")")"
#xclip -selection clipboard "$(echo -e "== [[$wikipath:$FullFilename\#$dateID|Zitat der Seite: $PageName]] ==\n $text\n Vom $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")")" &
#wl-copy --primary -n -f << '$(echo -e "== [[$wikipath:$FullFilename\#$dateID|Zitat der Seite: $PageName]] ==\n $text\n Vom $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")")'
#wl-copy -n < $outputText ;
wlexecution=$(echo -e $outputText | wl-copy -n &)
killall wl-copy
#echo -e $outputText | wl-copy -n ;
exit

@

```
