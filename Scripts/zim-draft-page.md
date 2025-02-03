# zim-draft-page
Created [2023-09-19]()

- [X]  **zim-draft-page** Christian Gößl [README.md](README.md)
	- [X] Doing
	- [X] Backlog

## Features



## Informations

Get yesterday's date in bash on Linux, DST-safe | AnonymousOverflow
https://overflow.hostux.net/questions/15374752/get-yesterdays-date-in-bash-on-linux-dst-safe


## Main Program

*run-cell.sh*
```bash
noweb.py -Rzim-draft-page.sh zim-draft-page.md > zim-draft-page.sh && echo 'fertig' 
```


```bash
chmod u+x zim-draft-page.sh && ln -sf $(pwd)/zim-draft-page.sh ~/.local/bin/zim-draft-page.sh && echo 'fertig'
 ```

*zim-draft-page.sh*
```bash
#*preamble}}

#*create xopp template}}

#*create page template}}

#*move page}}

```

### Presets

Einstellungen vor dem Start des eigentlichen Programms, hier für ein Shell Script ist diese Zeile notwendig

*preamble*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
inputDir="$(config_get inputDir)"
tempInputDir="$(config_get tempInputDir)"
templateDir="$(config_get templateDir)"
source tt-lib.sh
```

### Template for draft page


*create page template*
```bash
#create-note "$(pwd)" "$(date +"Draft page %Y-%m-%d")" "" "" ""
```


### Template for xopp file

*create xopp template*
```bash
file-description "$(pwd)" "$(date +"Draft_%Y-%m-%d".xopp)" "" "" ""
```


### Moving Page


*move page*
```bash
oldfilename=$(date -d "yesterday 13:00" +"Draft_page_%Y-%m-%d")
oldfilenamexopp=$(date -d "yesterday 13:00" +"Draft_%Y-%m-%d".xopp)
#mv -f $inputDir/"${oldfilename}".md $tempInputDir/"${oldfilename}".md 2>/dev/null
#mv -f $inputDir/"${filename}".md $tempInputDir/"${filename}".md 2>/dev/null
#mv -f "${filename}".md $inputDir/"${filename}".md 2>/dev/null

mv -f $inputDir/"${oldfilenamexopp}".md $tempInputDir/"${oldfilenamexopp}".md 2>/dev/null
mv -f $inputDir/"${filenamexopp}".md $tempInputDir/"${filenamexopp}".md 2>/dev/null
mv -f "${filenamexopp}".md $inputDir/"${filenamexopp}".md

mv -f $inputDir/"${oldfilenamexopp}" $tempInputDir/"${oldfilenamexopp}" 2>/dev/null
mv -f $inputDir/"${filenamexopp}" $tempInputDir/"${filenamexopp}" 2>/dev/null
cp $templateDir/Notiz-Vorlage.xopp $inputDir/"$filenamexopp"
```
