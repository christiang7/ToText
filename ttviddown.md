# ttviddown

- [X] **ttviddown**

Angelegt Donnerstag [Zettelkasten:2021:05:27]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

 ``youtube-dl --exec "ttdown {} [HREF] '[SELECTIONTEXT]' " [HREF]`` 


*run-cell.sh*
```bash
noweb.py -Rttviddown ttviddown.md > ttviddown && chmod u+x ttviddown && echo 'fertig'
```

*ttviddown*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalDir="$(config_get journalDir)"

File=$(date +"$journalDir/%Y/%m/%d.md" -r "$1")
f=$(basename "$1")
touch "$File"
echo -e "\n" >> "$File"
echo "Content-Type: text/x-zim-wiki" >> "$File".md
echo "Wiki-Format: zim 0.6" >> "$File".md
echo "===== $File =====" >> "$File".md
echo [ ] @VIDEO @VIDEOARCHIV "$2" "$f" >> "$File"
```


