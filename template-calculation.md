# template-calculation
Created [2023-06-25]()
 math
- [X] **template-calculation** [README.md](README.md)
	- [X] Doing
	- [X] Backlog

## Features



## Informations
Christian Gößl

External Tools
https://docs.kde.org/stable5/en/kate/kate/kate-application-plugin-external-tools.html


## Main Program

```bash
{{run-cell.sh}}=
noweb.py -Rtemplate-calculation.sh template-calculation.md > template-calculation.sh && echo 'fertig'
@
```


```bash
chmod u+x template-calculation.sh && ln -sf /home/christian/Gedankenspeicher/KanDo/GedankenspeicherEinrichtung/GedankenspeicherCoding/template-calculation.sh ~/.local/bin/template-calculation.sh && echo 'fertig'
 ```

```bash
{{template-calculation.sh}}=
{{preamble}}
yad --title="New calculation?" --text="\n Standalone File?\n"
if [ ! $? -eq 1 ];
then
  if [[ ! -e "$1" ]]
  then
	folder=$(pwd)
	#echo $folder
  else
	filetxt=$(readlink -f -n "$1")
	folder=${filetxt%.*}
	#echo $folder
	mkdir -p "$folder"
  fi
  File="Filename"
  cd $folder
  {{requests}}
else
  zim-template-calculation.sh "$1"
  #echo 2
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
{{requests}}=
abfrage=$(yad --title="New calculation?" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Filename" \
	--field="Shortname for language":CB \
	--field="Author":CBE \
	--field="Tags":CBE \
	--field="Description":TXT \
	"$File" "cpp,python,julia,html,css,javascript,bash,lua,plantuml,typst,other" "Christian Gößl,Internet" ",physic,math" "$additiontext")
if [ ! $? -eq 1 ];
then
	File=$(echo $abfrage | cut -s -d "~" -f 1)
	langname=$(echo $abfrage | cut -s -d "~" -f 2)
	source=$(echo $abfrage | cut -s -d "~" -f 3)
	tags=$(echo $abfrage | cut -s -d "~" -f 4)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 5)
	File=$(echo "$File" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')

	case ${langname} in
	cpp) extens="cpp"
		;;
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
	lua) extens="lua"
		;;
	plantuml) extens="plantuml" langname="pl"
		;;
	typst) extens="typ"
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
echo -e "# ${File}" >> "${File}".md
echo -e "Created [$(date +%Y-%m-%d)]($(date +%Y-%m-%d))" >> "${File}".md
echo -e "${tags}" >> "${File}".md
echo -e "- [X] **${File}**" >> "${File}".md
echo -e "    - [X] Doing" >> "${File}".md
echo -e "    - [X] Backlog" >> "${File}".md
echo -e "\n## Features" >> "${File}".md
echo -e "\n${additiontext}" >> "${File}".md
echo -e "\n## Informations" >> "${File}".md
echo -e " ${source}\n## Main Program" >> "${File}".md
echo -e "\n\`\`\`bash" >> "${File}".md
echo -e "{{run-cell.sh}}=" >> "${File}".md
if  [[ $extens == "plantuml" ]]
then
	echo -e "noweb.py -R${Filename}.${extens} ${File}.md > ${Filename}.${extens} && plantuml ${Filename}.${extens} && gwenview ${Filename}.png 2>/dev/null \n@\n\`\`\`" >> "${File}".md
elif [[ $extens == "typst" ]]
then
	echo -e "noweb.py -R${Filename}.${extens} ${File}.md > ${Filename}.${extens} && typst compile --format pdf ${Filename}.${extens} && xournalpp ${Filename}.pdf 2>/dev/null \n@\n\`\`\`" >> "${File}".md
elselangname
	echo -e "noweb.py -R${Filename}.${extens} ${File}.md > ${Filename}.${extens} && echo 'fertig' \n@\n\`\`\`" >> "${File}".md
	echo -e "\n\n\`\`\`bash" >> "${File}".md
	echo -e "chmod u+x ${Filename}.${extens} && ln -sf "${folder}"/${Filename}.${extens} ~/.local/bin/${Filename}.${extens} && echo 'fertig'\n \`\`\`" >> "${File}".md
fi
echo -e "\n\`\`\`${langname}" >> "${File}".md
echo -e "{{${Filename}.${extens}}}=" >> "${File}".md
if  [[ $extens == "plantuml" ]]
then
  echo -e "  @startuml\n" >> "${File}".md
  echo -e "  @enduml" >> "${File}".md
elif [[ $extens == "sh" ]]
then
  echo -e "#!/bin/bash" >> "${File}".md
fi
echo -e "\n@" >> "${File}".md
echo -e "\`\`\`" >> "${File}".md
touch ${File}
@

```
