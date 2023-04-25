# zim-template-program
Created Montag [Zettelkasten:2022:11:28]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **zim-template-program**  >  2277-11-11
	* ☐ hinzufügen von git, damit automatisch nen git repo erzeugt wird
	* ☐ Struktur überdenken mit README Datei und das die Datei in das Repo erzeugt wird und nicht auf der Ebene der txt Datei
	* ☐ probieren ob yad Ersatz für zenity funktioniert 


``noweb.py -Rzim-template-program.sh zim-template-program.md > zim-template-program.sh && echo "fertig"``


``chmod u+x zim-template-program.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/ZetteL/GedankenspeicherCoding/zim-template-program.sh ~/.local/bin/zim-template-program.sh && echo "fertig"``

```bash
Das komplette Programm
{{zim-template-program.sh}}=
{{preamble}}
{{Abruf txt Datei Ordner}}
{{Abfragen}}
{{create Template}}
fi
@
```

Einstellungen vor dem Start des eigentlichen Programms, hier für ein Shell Script ist diese Zeile notwendig

```bash
{{preamble}}=
#!/bin/bash
@
```
Den Ordner erstellen, wo die neue Datei gespeichert werden soll. Dabei wird der Pfad der Datei genommen und für die späteren Links gespeichert
```bash
{{Abruf txt Datei Ordner}}=
txtFile=$(echo "$1")
folder=${txtFile%.*}
mkdir -p "$folder"
cd "$folder"
filetxt=$(echo $2)
filepath=$(echo "${filetxt%/*}" | sed "s,/home/christian,~,")
wikipath=$(echo $filepath | sed "s,~/Gedankenspeicher/Gedankenspeicherwiki/,," | sed "s,/,:,g")
FullFilename=$(basename $filetxt .md)
@
```

```bash
{{Abfragen}}=
File="Program"
extens="sh"

abfrage=$(zenity --forms \
       --width 500 \
       --title "New Program?" \
       --text "Necessary Informations:" \
       --add-entry "Filename" --add-entry "Extension Standard sh")
       
if [ ! $? -eq 1 ]; 
then

if [[ ! "$abfrage" = "" ]]; 
then
	File=$(echo $abfrage | cut -s -d "|" -f 1)
	extens=$(echo $abfrage | cut -s -d "|" -f 2)
fi

File=$(echo "$File" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')

source="Christian Gößl"
tags=$(echo "$3")
additiontext=$(echo "$4")

abfrage=$(zenity --forms \
       --width 500 \
       --title "Noch etwas hinzufügen?" \
       --text "Noch etwas hinzufügen?" \
       --add-entry "Quelle Standard: Christian Gößl" --add-entry "Schlagwörter" --add-entry "Weiteres")
if [[ ! "$abfrage" = "" ]]; 
then
	source=$(echo $abfrage | cut -s -d "|" -f 1)
	tags=$(echo $abfrage | cut -s -d "|" -f 2)
	additiontext=$(echo $abfrage | cut -s -d "|" -f 3)
fi

@
```
Die Erzeugung des templates

```bash
{{create Template}}=
echo "Content-Type: text/x-zim-wiki" > "${folder}"/"${File}".md
echo "Wiki-Format: zim 0.6" >> "${folder}"/"${File}".md
echo -e "===== ${File} =====" >> "${folder}"/"${File}".md
echo -e "Created $(date +[[Zettelkasten:%Y:%m:%d]])" >> "${folder}"/"${File}".md
echo -e "Backlink [[$wikipath:$FullFilename]]" >> "${folder}"/"${File}".md
#"${filepath}.md
#echo -e "$([[Zettelkasten:%Y:%m:%d]])" >> "${folder}"/"${File}".md
echo -e "[[../]]" >> "${folder}"/"${File}".md
echo -e "[*] ${tags} ** ${File} ** ${source} >  2277-11-11" >> "${folder}"/"${File}".md
echo -e "\n${additiontext}" >> "${folder}"/"${File}".md
echo -e "\n''noweb.py -R${File}.${extens} ${File}.md > ${File}.${extens} && echo 'fertig'''" >> "${folder}"/"${File}".md
echo -e "\n\n''chmod u+x ${File}.${extens} && ln -sf "${folder}"/${File}.${extens} ~/.local/bin/${File}.${extens} && echo 'fertig'''" >> "${folder}"/"${File}".md
echo -e "\n{{{code: lang="sh" linenumbers="True"" >> "${folder}"/"${File}".md
echo -e "{{${File}.${extens}}}=" >> "${folder}"/"${File}".md
echo -e "\n@" >> "${folder}"/"${File}".md
echo -e "\n}}}" >> "${folder}"/"${File}".md

echo -e "\n[[+${File}]]" >> "${filetxt}.md"

@

```

