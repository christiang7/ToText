# zim-dot-update
Created Mittwoch [Zettelkasten:2022:06:08]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **zim-dot-update**

```bash
noweb.py -Rzim-dot-update.sh zim-dot-update.md > zim-dot-update.sh
```

```bash
chmod u+x zim-dot-update.sh && ln -sf $(pwd)/zim-dot-update.sh ~/.local/bin/zim-dot-update.sh && echo 'fertig'
```


*zim-dot-update.sh*
```bash
#! /bin/bash
if zenity --question --text="Möchten Sie das Diagramm aktualisieren?"
then
    File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
    filename=${File%.*}
    #mkdir -p "$filename"
    noweb.py -Rdiagram.dot "$File" > "$filename"/diagram.dot
    dot -Tpng "$filename"/diagram.dot -o "$filename"/diagram.png
    #echo "{{./diagram.png?type=diagram}}"
    #echo "$1" "$2" "$3" > ~/log.md
fi
```

