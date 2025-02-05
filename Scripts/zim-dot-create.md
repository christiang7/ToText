# zim-dot-create
Created Mittwoch [Zettelkasten:2022:06:08]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **zim-dot-create**

*run-cell.sh*
```bash
noweb.py -Rzim-dot-create.sh zim-dot-create.md > zim-dot-create.sh && chmod u+x zim-dot-create.sh && date
```

```bash
ln -sf $(pwd)/zim-dot-create.sh ~/.local/bin/zim-dot-create.sh && echo 'fertig'
```


*zim-dot-create.sh*
```bash
#! /bin/bash
yad --title="Create dot diagram in zim?" --text="\n Create dot diagram in zim\n"
if [ ! $? -eq 1 ];
then
    File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
    filename=${File%.*}
    mkdir -p "$filename"
    noweb.py -Rdiagram.dot "$File" > "$filename"/diagram.dot
    dot -Tpng "$filename"/diagram.dot -o "$filename"/diagram.png
    echo "{{./diagram.png?type=diagram}}"
    #echo "$1" "$2" "$3" > ~/log.md
fi
```

