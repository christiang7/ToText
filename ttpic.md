# ttpic
Text creation time: [Zettelkasten:2021:04:29]() Modification time: [Zettelkasten:2021:04:22]()
- [X] **[../ttpic](./ttpic)**



*run-cell.sh*
```bash
noweb.py -Rttpic ttpic.md > ttpic && chmod u+x ttpic && echo 'fertig'
```

*ttpic*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"

File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
#f=$(basename "$1")
touch "$File".md
echo "Content-Type: text/x-zim-wiki" >> "$File".md
echo "Wiki-Format: zim 0.6" >> "$File".md

#*zim-wiki}}

echo "Text date: $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]") Modi date: $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]" -r "$1")" >> "$File".md
echo "@BILD $3 " >> "$File".md
echo "**[[../$File]] **" >> "$File".md
#echo "Modification time: $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]" -r "$1")" >> "$File".md
echo -e "$2\n" >> "$File".md
echo "{{../$File?width=500}}" >> "$File".md
echo -e "\n$4" >> "$File".md
#kate "$File".md 2>/dev/null & 
#sleep 10
#kwrite
#echo fertig
```


### choose of markup language

#### zim wiki

*zim-wiki*
```bash
echo "====== $File ======" >> "$File".md
```


#### markdown

*markdown*
```bash
echo "# $File" >> "$File".md
```


