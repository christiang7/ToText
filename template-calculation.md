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
yad --title="New calculation?" --text="Standalone File?\n\n"
if [ ! $? -eq 1 ];
then
  folder=$(pwd)
  File="Filename"
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
	--field="Shortname for language":CB \
	--field="Author":CBE \
	--field="Tags":CBE \
	--field="Description":TXT \
	"$File" "python,julia,html,css,javascript,bash" "Christian Gößl,Internet" "physic,math" "$additiontext")
if [ ! $? -eq 1 ];
then
	File=$(echo $abfrage | cut -s -d "~" -f 1)
	langname=$(echo $abfrage | cut -s -d "~" -f 2)
	source=$(echo $abfrage | cut -s -d "~" -f 3)
	tags=$(echo $abfrage | cut -s -d "~" -f 4)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 5)
	File=$(echo "$File" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')

	case ${langname} in
	python) extens="py"
		;;
    julia) extens="jl"
		;;
    html) extens="html"
		;;
    css) extens="css"
		;;
    javascript) extens="js"
		;;
    bash) extens="sh"
		;;
    other) extens="other"
		;;
    esac
    Filename="$File"
    File="$File"."${extens}"

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
echo -e "${tags}" >> "${folder}"/"${File}".md
echo -e "- [X] **${File}** [README.md](README.md)" >> "${folder}"/"${File}".md
echo -e "    - [X] Doing" >> "${folder}"/"${File}".md
echo -e "    - [X] Backlog" >> "${folder}"/"${File}".md
echo -e "\n## Features" >> "${folder}"/"${File}".md
echo -e "\n${additiontext}" >> "${folder}"/"${File}".md
echo -e "\n## Informations" >> "${folder}"/"${File}".md
echo -e " ${source}\n## Main Program" >> "${folder}"/"${File}".md
echo -e "\n\`\`\`bash" >> "${folder}"/"${File}".md
echo -e "noweb.py -R${Filename}.${extens} ${File}.md > ${Filename}.${extens} && echo 'fertig' \n\`\`\`" >> "${folder}"/"${File}".md
echo -e "\n\n\`\`\`bash" >> "${folder}"/"${File}".md
echo -e "chmod u+x ${Filename}.${extens} && ln -sf "${folder}"/${Filename}.${extens} ~/.local/bin/${Filename}.${extens} && echo 'fertig'\n \`\`\`" >> "${folder}"/"${File}".md
echo -e "\n\`\`\`${langname}" >> "${folder}"/"${File}".md
echo -e "{{${Filename}.${extens}}}=" >> "${folder}"/"${File}".md
echo -e "\n@" >> "${folder}"/"${File}".md
echo -e "\`\`\`" >> "${folder}"/"${File}".md
touch "${folder}"/${File}
@

```
