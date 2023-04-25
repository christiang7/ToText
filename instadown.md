# instadown
Created Samstag [Zettelkasten:2022:04:09]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **instadown**  >  2277-11-11



  ``noweb.py -Rinstadown instadown.txt > instadown && chmod u+x instadown && echo 'fertig``'

```awk
<<instadown>>=
#!/bin/bash
folder=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d")
mkdir -p $folder
cd $folder
gallery-dl --no-mtime --exec "ttn {} '$1' " -D "$folder" "$1" &
ttn $File $1
@ 
```

