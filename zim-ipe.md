# zim-ipe
Created Mittwoch [Zettelkasten:2022:03:16]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **zim-ipe**  >  2277-11-11


  ``noweb.py -Rzim-ipe.sh zim-ipe.md > zim-ipe.sh && chmod u+x zim-ipe.sh && echo 'fertig'``

```bash
{{zim-ipe.sh}}=
#!/bin/bash
mkdir -p "$1"
ipe "$1/$2".ipe
iperender -png "$1/$2".ipe "$1/$2".png
echo {{"$2".png}}
@
```

