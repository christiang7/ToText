# ttf
Created Freitag [Zettelkasten:2022:05:20]()
Backlink [CodeFabrik]()

* ☑ **ttf**  >  2277-11-11


Ordner für die txt Datei erzeugen

  ``noweb.py -Rttf ttf.md > ttf && chmod u+x ttf && echo 'fertig'``

```bash
{{ttf}}=
#!/bin/bash
#File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
f=$(basename "$1" .md)
#extens=${f##*.} #only the extension of the file
filename=${f%.*} #only the filename
mkdir -p "$filename"
@
```

