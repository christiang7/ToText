# template-program
Created [2022-11-28]()

- [X] **template-program** [README.md](README.md)
	- [X] Doing
	- [X] Backlog
		- [ ] probieren ob yad Ersatz für zenity funktioniert
		- [ ] Auswahlmöglichkeit zwischen in einem bereits vorhanden Projekt ein Programm erstellen und ein ganz neues Programmierprojekt
			- [ ] hinzufügen von git bei neuem Programmierprojekt, damit automatisch nen git repo erzeugt wird

## Features

* Erstellung einer Vorlage für bestehendes Projekt
* nicht für zim-wiki
* bei der ersten Abfrage müssen alle Felder ausgewählt werden

## Program
```bash
noweb.py -Rtemplate-program.sh template-program.md > template-program.sh && echo "fertig"
```


```bash
chmod u+x template-program.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/GedankenspeicherCoding/template-program.sh ~/.local/bin/template-program.sh && echo "fertig"
```

### Main Program

Das komplette Programm
```bash
{{template-program.sh}}=
{{preamble}}
folder="$(pwd)"
{{Abfragen}}

@
```

### Presets

Einstellungen vor dem Start des eigentlichen Programms, hier für ein Shell Script ist diese Zeile notwendig

```bash
{{preamble}}=
#!/bin/bash
@
```

### requests


```bash
{{Abfragen}}=
File="Program"
extens="sh"
langname="bash"
abfrage=$(zenity --forms \
	   --width 500 \
	   --title "New Program?" \
	   --text "Necessary Informations:" \
	   --add-entry "Filename" --add-entry "Extension" --add-entry "Shortname for language")

if [ ! $? -eq 1 ];
then

	   if [[ ! "$abfrage" = "" ]];
	   then
			  File=$(echo $abfrage | cut -s -d "|" -f 1)
			  extens=$(echo $abfrage | cut -s -d "|" -f 2)
			  langname=$(echo $abfrage | cut -s -d "|" -f 3)
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

	   {{create Template}}
fi
@
```

### create template

Die Erzeugung des templates

```bash
{{create Template}}=
echo -e "# ${File}" >> "${folder}"/"${File}".md
echo -e "Created [[$(date +%Y-%m-%d)]]\n" >> "${folder}"/"${File}".md
echo -e "- [X] ${tags} **${File}** ${source} [README.md](README.md)" >> "${folder}"/"${File}".md
echo -e "    - [X] Doing" >> "${folder}"/"${File}".md
echo -e "    - [X] Backlog" >> "${folder}"/"${File}".md
echo -e "\n## Features" >> "${folder}"/"${File}".md
echo -e "\n${additiontext}" >> "${folder}"/"${File}".md
echo -e "\n\`\`\`bash\n noweb.py -R${File}.${extens} ${File}.md > ${File}.${extens} && echo 'fertig' \n\`\`\`" >> "${folder}"/"${File}".md
echo -e "\n\n\`\`\`bash\n chmod u+x ${File}.${extens} && ln -sf "${folder}"/${File}.${extens} ~/.local/bin/${File}.${extens} && echo 'fertig' \`\`\`" >> "${folder}"/"${File}".md
echo -e "\n\`\`\`${langname}" >> "${folder}"/"${File}".md
echo -e "{{${File}.${extens}}}=" >> "${folder}"/"${File}".md
echo -e "\n@" >> "${folder}"/"${File}".md
echo -e "\n\`\`\`" >> "${folder}"/"${File}".md


@

```

