# zim-clip-time

* ☑ **zim-clip-time**  

Created Freitag [Zettelkasten:2021:10:01]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)


Ein Script, was den Ort der Speicherung für zim-clip angibt. Damit kann sicher gestellt werden, dass immer beim Auslösen von zim-clip die richtige Zeit im Zettelkastensystem benutzt wird also die richtige Seite zum Datum. 

  ``noweb.py -Rzim-clip-time zim-clip-time.md > zim-clip-time && chmod u+x zim-clip-time && echo 'fertig'``

```bash
#<<zim-clip-time>>=
#!/bin/bash
Time=$(date +"Zettelkasten:%Y:%m:%d")
#folder=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d" -r "$1")
file="/home/christian/.config/zim/preferences.conf"
sed -i "183s/.*/marks=${Time}/" $file
sed -i "184s/.*/clips=${Time}/" $file

@
```



