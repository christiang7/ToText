# zim-dateheadlines
Created [2023-05-25]()
- [X]  **zim-dateheadlines**  [README.md](README.md)
   - [X] Doing
   - [X] Backlog

## Features



*run-cell.sh*
```bash
noweb.py -Rzim-dateheadlines.sh zim-dateheadlines.md > zim-dateheadlines.sh && echo 'fertig'
```


```bash
chmod u+x zim-dateheadlines.sh && ln -sf ~/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/GedankenspeicherCoding/zim-dateheadlines.sh ~/.local/bin/zim-dateheadlines.sh && echo 'fertig'
```

*zim-dateheadlines.sh*
```bash
#!/bin/bash

#*dateheadlines}}

```

simples einfügen der Überschrift mit einem Datum

*dateheadlines*
```bash
echo -e "==== $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]") "
```

*dateheadlines markdown*
```bash
echo -e "## $(date +"[[Zettelkasten/%Y/%m/%d|%Y-%m-%d]]") "
```