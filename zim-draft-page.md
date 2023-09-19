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

```bash
noweb.py -Rzim-draft-page.sh zim-draft-page.md > zim-draft-page.sh && echo 'fertig' 
```


```bash
chmod u+x zim-draft-page.sh && ln -sf /home/christian/Gedankenspeicher/KanDo/GedankenspeicherEinrichtung/GedankenspeicherCoding/zim-draft-page.sh ~/.local/bin/zim-draft-page.sh && echo 'fertig'
 ```

```bash
{{zim-draft-page.sh}}=
{{preamble}}
{{create page template}}
{{move page}}
@

```

### Presets

Einstellungen vor dem Start des eigentlichen Programms, hier für ein Shell Script ist diese Zeile notwendig

```bash
{{preamble}}=
#!/bin/bash
@
```

### Template for draft page




```bash
{{create page template}}=
filename=$(date +"Draft_page_%Y-%m-%d")
touch "${filename}".md
echo "Content-Type: text/x-zim-wiki" > "${filename}".md
echo "Wiki-Format: zim 0.6" >> "${filename}".md
echo -e "===== $(date +"Draft page %Y-%m-%d") =====" >> "${filename}".md
echo -e "Created $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")" >> "${filename}".md
echo -e "[*] ** $(date +"Draft page %Y-%m-%d") ** [[Artelier:Inputs|Inputs]] \n\n" >> "${filename}".md
@
```


### Moving Page


```bash
{{move page}}=
oldfilename=$(date -d "yesterday 13:00" +"Draft_page_%Y-%m-%d")
mv -f ~/Downloads/"${oldfilename}".md ~/Alte-Inputs/"${oldfilename}".md 2>/dev/null
mv -f ~/Downloads/"${filename}".md ~/Alte-Inputs/"${filename}".md 2>/dev/null
mv -f "${filename}".md ~/Downloads/"${filename}".md 2>/dev/null
@
```
