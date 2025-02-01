# zim-index
Created Donnerstag [Zettelkasten:2022:06:30]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **zim-index**

*run-cell.sh*
```bash
noweb.py -Rzim-index.sh zim-index.md > zim-index.sh && chmod u+x zim-index.sh && ln -sf $(pwd)/zim-index.sh ~/.local/bin/zim-index.sh && echo 'fertig'
```


*zim-index.sh*
```bash
#!/bin/bash
source config.sh; # load the config library functions
zimWikiName="$(config_get zimWikiName)"
zimDir="$(config_get zimDir)"

sleep 20 && $zimDir/zim.py --index $zimWikiName
```

