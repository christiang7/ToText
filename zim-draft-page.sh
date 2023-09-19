#!/bin/bash
filename=$(date +"Draft_page_%Y-%m-%d")
touch "${filename}".md
echo "Content-Type: text/x-zim-wiki" > "${filename}".md
echo "Wiki-Format: zim 0.6" >> "${filename}".md
echo -e "===== $(date +"Draft page %Y-%m-%d") =====" >> "${filename}".md
echo -e "Created $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")" >> "${filename}".md
echo -e "[*] ** $(date +"Draft page %Y-%m-%d") ** [[Artelier:Inputs|Inputs]] \n\n" >> "${filename}".md
oldfilename=$(date -d "yesterday 13:00" +"Draft_page_%Y-%m-%d")
mv -f ~/Downloads/"${oldfilename}".md ~/Alte-Inputs/"${oldfilename}".md 2>/dev/null
mv -f ~/Downloads/"${filename}".md ~/Alte-Inputs/"${filename}".md 2>/dev/null
mv -f "${filename}".md ~/Downloads/"${filename}".md 2>/dev/null
