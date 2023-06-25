# template-calculation
Created [2023-06-25]()

- [X] math **template-calculation** Christian Gößl [README.md](README.md)
    - [X] Doing
    - [X] Backlog

## Features



## Informations

## Main Program

```bash
 noweb.py -Rtemplate-calculation.sh template-calculation.md > template-calculation.sh && echo 'fertig' 
```


```bash
 chmod u+x template-calculation.sh && ln -sf /home/christian/Gedankenspeicher/KanDo/GedankenspeicherEinrichtung/GedankenspeicherCoding/template-calculation.sh ~/.local/bin/template-calculation.sh && echo 'fertig'
 ```

```bash
{{template-calculation.sh}}=
{{preamble}}

if [[ ! -e "$1" ]]
then
  folder=$(pwd)
  {{Abfragen}}
else
  zim-template-calculation.sh "$1"
fi

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
abfrage=$(yad --title="New calculation?" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Filename" \
	--field="Shortname for language":CBE \
	--field="Extension":CBE \
	--field="Author":CBE \
	--field="Tags":CBE \
	--field="Description":TXT \
	"$File" "python,julia,html,css,javascript,bash" "py,jl,html,css,js,sh" "Christian Gößl,Internet" "physic,math" "$additiontext")
if [ ! $? -eq 1 ];
then
	File=$(echo $abfrage | cut -s -d "~" -f 1)
	langname=$(echo $abfrage | cut -s -d "~" -f 2)
	extens=$(echo $abfrage | cut -s -d "~" -f 3)
	source=$(echo $abfrage | cut -s -d "~" -f 4)
	tags=$(echo $abfrage | cut -s -d "~" -f 5)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 6)
	File=$(echo "$File" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
    {{create Template}}
fi
@
```

### create template

Creating template

```bash
{{create Template}}=
echo -e "# ${File}" >> "${folder}"/"${File}".md
echo -e "Created [$(date +%Y-%m-%d)]()\n" >> "${folder}"/"${File}".md
echo -e "- [X] ${tags} **${File}** ${source} [README.md](README.md)" >> "${folder}"/"${File}".md
echo -e "    - [X] Doing" >> "${folder}"/"${File}".md
echo -e "    - [X] Backlog" >> "${folder}"/"${File}".md
echo -e "\n## Features" >> "${folder}"/"${File}".md
echo -e "\n${additiontext}" >> "${folder}"/"${File}".md
echo -e "\n## Informations" >> "${folder}"/"${File}".md
echo -e "\n## Main Program" >> "${folder}"/"${File}".md
echo -e "\n\`\`\`bash\n noweb.py -R${File}.${extens} ${File}.md > ${File}.${extens} && echo 'fertig' \n\`\`\`" >> "${folder}"/"${File}".md
echo -e "\n\n\`\`\`bash\n chmod u+x ${File}.${extens} && ln -sf "${folder}"/${File}.${extens} ~/.local/bin/${File}.${extens} && echo 'fertig'\n \`\`\`" >> "${folder}"/"${File}".md
echo -e "\n\`\`\`${langname}" >> "${folder}"/"${File}".md
echo -e "{{${File}.${extens}}}=" >> "${folder}"/"${File}".md
echo -e "\n@" >> "${folder}"/"${File}".md
echo -e "\n\`\`\`" >> "${folder}"/"${File}".md
@

```
