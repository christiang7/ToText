# ttdvid

* ☑ **ttdvid**  

Created Sonntag [Zettelkasten:2021:05:23]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

  ``noweb.py -Rttdvid ttdvid.md > ttdvid && chmod u+x ttdvid && echo 'fertig'``

```bash
	<<ttdvid>>=
	#!/bin/bash
	ls --hide=*.txt --hide=*.srt --hide=*.ttml "$1" > f
	while read f
	do
	  echo $(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d.txt" -r "$1"/"$f")
	  File=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d.txt" -r "$1"/"$f")
	  g=$(basename "$1"/"$f")
	  touch "$File"
	  echo -e "\n" >> "$File"
	  echo [ ] >2277-11-11 @VIDEO @VIDEOARCHIV "$2" "$g" >> "$File"
	done < f
	rm f
	@ 
```
