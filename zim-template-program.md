# zim-template-program
Created Montag [2022-11-28]()
- [X] **zim-template-program**  [README](README.md)
    - [X] Doing
        - [ ] hinzufügen von git bei neuem Programmierprojekt, damit automatisch nen git repo erzeugt wird
			- [ ] create README and add to git
        - [ ] README template
    - [X] Backlog


```bash
noweb.py -Rzim-template-program.sh zim-template-program.md > zim-template-program.sh && echo "fertig"
```


```bash
chmod u+x zim-template-program.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/ZetteL/GedankenspeicherCoding/zim-template-program.sh ~/.local/bin/zim-template-program.sh && echo "fertig"
```

Das komplette Programm
```bash
{{zim-template-program.sh}}=

{{preamble}}

{{Abruf txt Datei Ordner}}

{{Abfragen}}

@
```

### Preamble

Einstellungen vor dem Start des eigentlichen Programms, hier für ein Shell Script ist diese Zeile notwendig

```bash
{{preamble}}=
#!/bin/bash
@
```

### Abruf wo sich die Datei befindet

Den Ordner erstellen, wo die neue Datei gespeichert werden soll. Dabei wird der Pfad der Datei genommen und für die späteren Links gespeichert
```bash
{{Abruf txt Datei Ordner}}=
filetxt=$(readlink -f -n "$1")
folder=${filetxt%.*}
mkdir -p "$folder"
cd "$folder"
#filetxt=$(echo $2)
#filepath=$(echo "${filetxt%/*}" | sed "s,/home/christian,~,")
#wikipath=$(echo $filepath | sed "s,~/Gedankenspeicher/Gedankenspeicherwiki/,," | sed "s,/,:,g")
#FullFilename=$(basename $filetxt .md)
@
```

### Abfrage was genau angelegt werden soll

```bash
{{Abfragen}}=
abfrage=$(yad --title="New Project Program" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Projectname" \
	--field="Filename" \
	--field="Shortname for language":CBE \
	--field="Extension":CBE \
	--field="Author":CBE \
	--field="Tags":CBE \
	--field="Description":TXT \
	"$Project" "$File" "$langname,bash,python,julia,html,css,javascript" "$extens,sh,py,jl,html,css,js" "$source,Christian Gößl,Internet" "$tags,physic,math" "$additiontext")
if [ ! $? -eq 1 ];
then
	Project=$(echo $abfrage | cut -s -d "~" -f 1)
	File=$(echo $abfrage | cut -s -d "~" -f 2)
	langname=$(echo $abfrage | cut -s -d "~" -f 3)
	extens=$(echo $abfrage | cut -s -d "~" -f 4)
	source=$(echo $abfrage | cut -s -d "~" -f 5)
	tags=$(echo $abfrage | cut -s -d "~" -f 6)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 7)
	File=$(echo "$File" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')

    #{{zim file folder}} #Ordner erstellen

    {{readme file}}
    #README template
    {{program template}}

    {{git init}}

fi
@

```
### create README file


```bash
{{readme file}}=
echo -e "# ${Project}" >> "README".md
echo -e "Created [$(date +%Y-%m-%d)]()\n" >> "README".md
echo -e "- [X] ${tags} **${Project}** " >> "README".md
echo -e "    - [X] Done" >> "README".md
echo -e "    - [X] Doing Interput" >> "README".md
echo -e "    - [X] Doing" >> "README".md
echo -e "    - [X] Next" >> "README".md
echo -e "    - [X] Planning" >> "README".md
echo -e "    - [X] Backlog" >> "README".md
echo -e "       - [ ] [${File}](${File}.md)" >> "README".md
echo -e "\n## Features" >> "README".md
echo -e "\n## Description" >> "README".md
echo -e "\n${additiontext}" >> "README".md
@

```


### create Template

Die Erzeugung des templates

```bash
{{program template}}=
echo -e "# ${File}" >> "${File}".md
echo -e "Created [$(date +%Y-%m-%d)]()\n" >> "${File}".md
echo -e "- [X] ${tags} **${File}** [README](README.md)" >> "${File}".md
echo -e "    - [X] Doing" >> "${File}".md
echo -e "    - [X] Backlog" >> "${File}".md
echo -e "       - [ ] " >> "${File}".md
echo -e "\n## Features" >> "${File}".md
echo -e "\n## Informations" >> "${File}".md
echo -e "\n## Main Program" >> "${File}".md
echo -e "\n\`\`\`bash\n noweb.py -R${File}.${extens} ${File}.md > ${File}.${extens} && echo 'fertig' \n\`\`\`" >> "${File}".md
echo -e "\n\n\`\`\`bash\n chmod u+x ${File}.${extens} && ln -sf "$folder"/${File}.${extens} ~/.local/bin/${File}.${extens} && echo 'fertig'\n \`\`\`" >> "${File}".md
echo -e "\n\`\`\`${langname}" >> "${File}".md
echo -e "{{${File}.${extens}}}=" >> "${File}".md
echo -e "\n@" >> "${File}".md
echo -e "\n\`\`\`" >> "${File}".md
@

```

### git versioning

```bash
{{git init}}=
git init
git add README.md
git add "${File}".md
git commit -a -m "init git"

@
```