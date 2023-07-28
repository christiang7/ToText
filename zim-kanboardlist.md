# zim-kanboardlist
Created 2023-05-25
- [X]  **zim-kanboardlist**  [README.md](README.md)
   - [X] Doing
   - [X] Backlog

## Features
einfügen von einer Standard Kanboardliste für zim-wiki

## Program

```bash
noweb.py -Rzim-kanboardlist.sh zim-kanboardlist.md > zim-kanboardlist.sh && echo 'fertig'
```


```bash
chmod u+x zim-kanboardlist.sh && ln -sf ~/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/GedankenspeicherCoding/zim-kanboardlist.sh ~/.local/bin/zim-kanboardlist.sh && echo 'fertig'
```

## Main program

```bash
{{zim-kanboardlist.sh}}=
#!/bin/bash
{{list}}
@

```

Die Standardliste für das Gedankenspeicherprojekt für Kanboards

```bash
{{list}}=
echo "    [*] Done" 
echo "    [*] Doing Interput ② "
echo "    [*] Doing ② "
echo "    [*] Next ②"
echo "    [*] Planung ②"
echo "    [*] Backlog"
@
