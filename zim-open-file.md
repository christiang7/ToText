# zim-open-file
Created [2023-06-25]()
- [X]  **zim-open-file**  [README.md](README.md)
    - [X] Doing
        - [ ] Problem with files in zim with german Umlaute
    - [X] Backlog


## Features


## Program

```bash
{{run-cell.sh}}=
noweb.py -Rzim-open-file.sh zim-open-file.md > zim-open-file.sh && echo 'fertig'
@
```


```bash
 chmod u+x zim-open-file.sh && ln -sf /home/christian/Gedankenspeicher/KanDo/GedankenspeicherEinrichtung/GedankenspeicherCoding/zim-open-file.sh ~/.local/bin/zim-open-file.sh && echo 'fertig'
 ```

### Main Program

```bash
{{zim-open-file.sh}}=
#!/bin/bash
file=$(readlink -f -n "$1")
Filename=$(basename $file .md)
#echo "xdg-open $Filename/$Filename"
{{With folder}}
@

```

```bash
{{With folder}}=
cd $Filename
Filename="$(echo ${Filename} | sed -e 's/a\xcc\x88/ä/' | sed -e 's/o\xcc\x88/ö/' | sed -e 's/u\xcc\x88/ü/' | sed -e 's/A\xcc\x88/Ä/' | sed -e 's/O\xcc\x88/Ö/' | sed -e 's/U\xcc\x88/Ü/')"
#xdg-open $Filename/$Filename
xdg-open $Filename
#output="$(eval xdg-open $Filename)"
#output="$(eval echo hello 2>&1)"
#yad --timeout=15 --timeout-indicator=top --form --separator="|" --item-separator="," \
#	--field="Output Script:":TXT \
#	"$output" --mouse
@
```

```bash
{{Without folder}}=
xdg-open $Filename
@
```
