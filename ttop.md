# ttop
Created Dienstag [Zettelkasten:2022:03:15]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **ttop**  >  2277-11-11


Öffne die annotierte Datei

  ``noweb.py -Rttop ttop.md > ttop && chmod u+x ttop && echo 'fertig'``

```bash
{{ttop}}=
#!/bin/bash
f=$(basename "$1")
extens=${f##*.} #only the extension of the file
filename=${f%.*} #only the filename
xdg-open "$filename" 2>/dev/null &
@
```

