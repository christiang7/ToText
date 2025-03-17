# zim-dateheadlines
Created [2023-05-25]()
- [x]  **zim-dateheadlines**  [README.md](README.md)
   - [x] Doing
   - [x] Backlog

## Features



*run-cell.sh*
```bash
noweb.py -Rzim-dateheadlines.sh zim-dateheadlines.md > zim-dateheadlines.sh && echo 'fertig'
```


```bash
chmod u+x zim-dateheadlines.sh && ln -sf $(pwd)/zim-dateheadlines.sh ~/.local/bin/zim-dateheadlines.sh && echo 'fertig'
```

### zim-dateheadlines.sh
*zim-dateheadlines.sh*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"

#*dateheadlines}}

```

### dateheadlines
simples einfügen der Überschrift mit einem Datum

*dateheadlines*
```bash
echo -e "==== $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]") "
```

### dateheadlines markdown

*dateheadlines markdown*
```bash
echo -e "## $(date +"[[$journalPage/%Y/%m/%d|%Y-%m-%d]]") "
```