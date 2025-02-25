# zim-kanboardlist
Created 2023-05-25
- [x]  **zim-kanboardlist**  [README.md](README.md)
   - [x] Doing
   - [x] Backlog

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
echo "    [*] Backlog"
echo "    [*] Planung ②"
echo "    [*] Next ②"
echo "    [*] Doing ② "
```

