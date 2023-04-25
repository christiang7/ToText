# zim-insert-picture
Created Donnerstag [Zettelkasten:2022:12:29]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ @NOTIZ @PROGRAMM @SCRIPT  **zim-insert-picture.sh**  >  2277-11-11


Für die Benutzung von Krita und der export in der Kommandozeile, weil Krita speichert die Layer Einstellungen nicht in der Datei ab.

``krita Vorlage-Notiz.kra --export --export-filename Vorlage-Notiz.avif``



``noweb.py -Rzim-insert-picture.sh zim-insert-picture.md > zim-insert-picture.sh && echo 'fertig'``

 ``chmod u+x zim-insert-picture.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/GedankenspeicherCoding/zim-insert-picture.sh ~/.local/bin/zim-insert-picture.sh && echo 'fertig'``

```bash
<<zim-insert-picture.sh>>=
#!/bin/bash
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
filetxt=${File%.*}
datum=$(date +"%Y-%m-%d--%H-%M-%S")
Newname=$(zenity --entry \
       --width 500 \
       --title "Type new filename" \
       --text "Enter new filename" \
       --entry-text "_${datum}")
if [ ! "$Newname" = "" ]; 
then
	filename=$(echo "$Newname" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
	mkdir -p "$filetxt"
	cd "$filetxt"
	cp ~/Gedankenspeicher/Gedankenspeicherwiki/Vorlagen/Vorlage-Notiz.kra "$filename".kra
	xterm -e "krita "$filename".kra"
	krita "$filename".kra --export --export-filename "$filename".avif
	
	File=$(echo "$filename".kra)
	touch "$File".md
	echo "Content-Type: text/x-zim-wiki" >> "$File".md
	echo "Wiki-Format: zim 0.6" >> "$File".md
	echo "===== $File =====" >> "$File".md
	echo "[*] @NOTIZ @BILD **[[../"$filename".kra]] Christian Gößl **" >> "$File".md
	echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" >> "$File".md
	echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$1")" >> "$File".md
	echo -e "[[../]]\n" >> "$File".md
	echo "{{../"$filename".avif?width=750}}" >> "$File".md
	echo -e "\n" >> "$File".md
	
	echo -e "[[+${filename}.kra]]"
	echo {{"$filename".avif?width=750}}
fi
@
```

