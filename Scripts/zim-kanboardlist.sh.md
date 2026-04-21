# zim-kanboardlist.sh
Created 2023-05-25

- [x] Doing
- [x] Backlog

## Features
einfügen von einer Standard Kanboardliste für zim-wiki

## Program

*make.sh*
```bash
noweb.py -Rzim-kanboardlist.sh zim-kanboardlist.sh.md > zim-kanboardlist.sh && echo 'fertig'
```

## zim-kanboardlist.sh

*zim-kanboardlist.sh*
```bash
#!/bin/bash

#*list}}

```

### Insert list
Die Standardliste für das Gedankenspeicherprojekt für Kanboards

*list*
```bash
echo "- [*] Backlog"
echo "- [*] Planung (2)"
echo "- [*] Next (2)"
echo "- [*] Doing (2)"
```

