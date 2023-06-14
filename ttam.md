# ttam
Created [Zettelkasten:2023:03:06]()
Backlink [CodeFabrik:GedankenspeicherCoding](../GedankenspeicherCoding.md)

* [X] **ttam**   >  2277-11-11

	da sollte eventuell auch eingebaut werden, dass die originale Pfad in die Datei geschrieben wird
	Zustände: 
		1: Datei hat noch keine txt Datei, Datei wird eine txt bekommen
		2: Datei hat schon eine txt Datei, keine txt geben
	Ausführen: 
		Datei wird mit txt Datei verlinkt in den Ordner
		Ablauf: Zim txt Datei auswählen, rechtsklick copy path, gehe zu txt Ordner und klicke auf zim button tools mit eigenem Script(das verlinkt alles und setzt in der Originaldatei den
		Originallink

Program for moving files to the assets folder 



``noweb.py -Rttam.sh ttam.md > ttam.sh && echo 'fertig'``


``chmod u+x ttam.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/GedankenspeicherCoding/ttam.sh ~/.local/bin/ttam.sh && echo 'fertig'``

```bash
{{ttam.sh}}=
#!/usr/bin/env bash



folder=$(readlink -f -n "$1")
folder="${folder%/*}"

filename=$(ttrename "$1" 2> /dev/null)

#file=$(basename "$folder" .md)


#filename=${file%.*}

assetsfolder=$(echo ~/Gedankenspeicher/Gedankenspeicherwiki/Assets)
wikipath=$(echo $assetsfolder | sed "s,/home/christian/Gedankenspeicher/Gedankenspeicherwiki/,," | sed "s,/,:,g")

mv "$folder"/"$filename" "$assetsfolder"/"$filename"
#mv "$folder"/"$file" "$assetsfolder"/"$file"

mv "$folder"/"${filename}"_files "$assetsfolder"/"${filename}"_files
mv "$folder"/"${filename}"-Dateien "$assetsfolder"/"${filename}"-Dateien
mv "$folder"/"${filename}"_Dateien "$assetsfolder"/"${filename}"_Dateien

mv "$folder"/"$filename".png "$assetsfolder"/"$filename".png
mv "$folder"/"$filename".avif "$assetsfolder"/"$filename".avif
mv "$folder"/"$filename".md "$assetsfolder"/"$filename".md

echo -e "[[$assetsfolder/$filename]]\n[[$wikipath:$filename]]" >> "$assetsfolder"/"$filename".md
@

```

