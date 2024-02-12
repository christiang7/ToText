#!/bin/bash
filenamexopp=$(date +"Draft_%Y-%m-%d".xopp)
touch "${filenamexopp}".md
echo "Content-Type: text/x-zim-wiki" > "${filenamexopp}".md
echo "Wiki-Format: zim 0.6" >> "${filenamexopp}".md
echo -e "====== $(date +"Draft %Y-%m-%d") ======" >> "${filenamexopp}".md
echo -e "Created $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")" >> "${filenamexopp}".md
echo -e "[*] **[[../$filenamexopp]]** \n\n" >> "${filenamexopp}".md
oldfilename=$(date -d "yesterday 13:00" +"Draft_page_%Y-%m-%d")
oldfilenamexopp=$(date -d "yesterday 13:00" +"Draft_%Y-%m-%d".xopp)
#mv -f ~/Downloads/"${oldfilename}".md ~/Alte-Inputs/"${oldfilename}".md 2>/dev/null
#mv -f ~/Downloads/"${filename}".md ~/Alte-Inputs/"${filename}".md 2>/dev/null
#mv -f "${filename}".md ~/Downloads/"${filename}".md 2>/dev/null

mv -f ~/Downloads/"${oldfilenamexopp}".md ~/Alte-Inputs/"${oldfilenamexopp}".md 2>/dev/null
mv -f ~/Downloads/"${filenamexopp}".md ~/Alte-Inputs/"${filenamexopp}".md 2>/dev/null
mv -f "${filenamexopp}".md ~/Downloads/"${filenamexopp}".md

mv -f ~/Downloads/"${oldfilenamexopp}" ~/Alte-Inputs/"${oldfilenamexopp}" 2>/dev/null
mv -f ~/Downloads/"${filenamexopp}" ~/Alte-Inputs/"${filenamexopp}" 2>/dev/null
cp ~/Gedankenspeicher/Vorlagen/Notiz-Vorlage.xopp ~/Downloads/"$filenamexopp"
