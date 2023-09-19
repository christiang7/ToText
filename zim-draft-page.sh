#!/bin/bash
filename=$(date +"Draft_page_%Y-%m-%d")
touch "${filename}".md
echo "Content-Type: text/x-zim-wiki" > "${filename}".md
echo "Wiki-Format: zim 0.6" >> "${filename}".md
echo -e "===== $(date +"Draft page %Y-%m-%d") =====" >> "${filename}".md
echo -e "Created $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")" >> "${filename}".md
echo -e "[*] ** $(date +"Draft page %Y-%m-%d") ** [[Artelier:Input|Input]] \n\n" >> "${filename}".md
mv ~/Downloads/"${filename}".md ~/Alte-Inputs/"${filename}".md
mv "${filename}".md ~/Downloads/"${filename}".md
