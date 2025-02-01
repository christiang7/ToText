# zim-clip-time

- [X] **zim-clip-time**

Created Freitag [Zettelkasten:2021:10:01]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)


Ein Script, was den Ort der Speicherung für zim-clip angibt. Damit kann sicher gestellt werden, dass immer beim Auslösen von zim-clip die richtige Zeit im Zettelkastensystem benutzt wird also die richtige Seite zum Datum. 

*run-cell.sh*
```bash
noweb.py -Rzim-clip-time zim-clip-time.md > zim-clip-time && echo 'fertig'
```


```bash
chmod u+x zim-clip-time && echo 'fertig'
```

*zim-clip-time*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
journalDir="$(config_get journalDir)"
homeDir="$(config_get homeDir)"

Time=$(date +"$journalPage:%Y:%m:%d")
#folder=$(date +"$journalDir/%Y/%m/%d" -r "$1")
file="$homeDir/.config/zim/preferences.conf"
sed -i "206s/.*/marks=${Time}/" $file
sed -i "207s/.*/clips=${Time}/" $file
```



