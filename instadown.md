# instadown
Created Samstag [Zettelkasten:2022:04:09]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **instadown**

  ``noweb.py -Rinstadown instadown.md > instadown && chmod u+x instadown && echo 'fertig'``



*instadown*
```bash
#!/bin/bash
folder=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d")
mkdir -p $folder
cd $folder
gallery-dl --no-mtime --exec "ttn {} '$1' " -D "$folder" "$1" &
ttn $File $1
```

