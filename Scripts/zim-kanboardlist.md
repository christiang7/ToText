# zim-kanboardlist
Created 2023-05-25
- [X]  **zim-kanboardlist**  [README.md](README.md)
   - [X] Doing
   - [X] Backlog

## Features
einfügen von einer Standard Kanboardliste für zim-wiki

## Program

*run-cell.sh*
```bash
noweb.py -Rzim-kanboardlist.sh zim-kanboardlist.md > zim-kanboardlist.sh && echo 'fertig'
```

## Main program

*zim-kanboardlist.sh*
```bash
#!/bin/bash

#*list}}

```

### Insert list
Die Standardliste für das Gedankenspeicherprojekt für Kanboards

*list*
```bash
echo "    [*] Done" 
echo "    [*] Doing Interput ② "
echo "    [*] Doing ② "
echo "    [*] Next ②"
echo "    [*] Planung ②"
echo "    [*] Backlog"
```