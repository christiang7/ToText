# zim-index
Created Donnerstag [Zettelkasten:2022:06:30]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **zim-index**  >  2277-11-11


  ``noweb.py -Rzim-index.sh zim-index.md > zim-index.sh && chmod u+x zim-index.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Gedankenwanderung/Programme/zim-index.sh ~/.local/bin/zim-index.sh && echo 'fertig'``


```bash
#<<zim-index.sh>>=
#! /bin/bash
sleep 20 && ~/Programme/zim/zim.py --index Gedankenspeicherwiki
@
```

