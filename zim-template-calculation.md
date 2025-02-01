# zim-template-calculation
Created [2023-06-25]()
math
- [X] **zim-template-calculation** [README.md](README.md)
    - [X] Doing
    - [X] Backlog

## Features



## Informations
 Christian Gößl


## Main Program

*run-cell.sh*
```bash
noweb.py -Rzim-template-calculation.sh zim-template-calculation.md > zim-template-calculation.sh && echo 'fertig'
```


```bash
chmod u+x zim-template-calculation.sh && ln -sf $(pwd)/zim-template-calculation.sh ~/.local/bin/zim-template-calculation.sh && echo 'fertig'
 ```



*zim-template-calculation.sh*
```bash
#*preamble}}

#*Abruf txt Datei Ordner}}

#*Abfragen}}

```

### Preamble

Einstellungen vor dem Start des eigentlichen Programms, hier für ein Shell Script ist diese Zeile notwendig

*preamble*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"

```

### Abruf wo sich die Datei befindet

Den Ordner erstellen, wo die neue Datei gespeichert werden soll. Dabei wird der Pfad der Datei genommen und für die späteren Links gespeichert

*Abruf txt Datei Ordner*
```bash
if [[ -e "$1" ]]
then
    filetxt=$(readlink -f -n "$1")
    folder=${filetxt%.*}
    #Project=$(basename $folder)
else
    #Project="Projectname"
    folder=$(pwd)
fi
echo $folder
cd $folder
File="Filename"
Project="Projectname"
```

### Abfrage was genau angelegt werden soll

*Abfragen*
```bash
abfrage=$(yad --title="New Project calculation" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Projectname" \
	--field="Filename" \
	--field="Shortname for language":CB \
	--field="Author":CBE \
	--field="Tags":CBE \
	--field="Description":TXT \
	"$Project" "$File" "cpp,python,julia,html,css,bash,javascript,lua,other" "Christian Gößl,Internet" ",physic,math" "$additiontext")
if [ ! $? -eq 1 ];
then
	Project=$(echo $abfrage | cut -s -d "~" -f 1)
	File=$(echo $abfrage | cut -s -d "~" -f 2)
	langname=$(echo $abfrage | cut -s -d "~" -f 3)
	source=$(echo $abfrage | cut -s -d "~" -f 4)
	tags=$(echo $abfrage | cut -s -d "~" -f 5)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 6)
	File=$(echo "$File" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
    ProjectName="$Project"
    Project=$(echo "$Project" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')

	mkdir -p "$Project"
    cd "$Project"

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
    other) extens="other"
		;;
    esac

    Filename="$File"
    File="$File"."${extens}"

    #*Using zim}}

    #*readme file}}

    #*calculation template}}

    #*git init}}

fi
```

### Using zim?
When the program is used not for zim pages, then we create a zim file.

*Using zim*
```bash
if [[ ! -e ../"$Project".md ]]
then
	folder="$Project"
	#touch ../"$folder".md
	echo -e "====== $ProjectName ======" >> ../"$folder".md
	echo -e "Created $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]")" >> ../"$folder".md
	echo -e "[*] ** $folder **" >> ../"$folder".md
fi
```

### Using Markdown?
When the program is used not for zim pages, then we create a zim file.

*Using markdown*
```bash
if [[ ! -e ../"$Project".md ]]
then
	folder="$Project"
	#touch ../"$folder".md
	echo -e "# $ProjectName" >> ../"$folder".md
	echo -e "Created $(date +"[[$journalPage/%Y/%m/%d|%Y-%m-%d]]")" >> ../"$folder".md
	echo -e "- [X] ** $folder **" >> ../"$folder".md
fi
```

### create README file


*readme file*
```bash
echo -e "# README" >> "README".md
echo -e "Created [$(date +%Y-%m-%d)]()\n" >> "README".md
echo -e "${tags} " >> "README".md
echo -e "- [X] **${ProjectName}** " >> "README".md
echo -e "    - [X] Done" >> "README".md
echo -e "    - [X] Doing Interput" >> "README".md
echo -e "    - [X] Doing" >> "README".md
echo -e "       - [ ] [${File}](${File}.md)" >> "README".md
echo -e "    - [X] Next" >> "README".md
echo -e "    - [X] Planning" >> "README".md
echo -e "    - [X] Backlog" >> "README".md
echo -e "\n## Features" >> "README".md
echo -e "\n## Description" >> "README".md
echo -e "\n${additiontext}" >> "README".md
```


### create Template

Die Erzeugung des templates

*calculation template*
```bash
echo -e "# ${File}" >> "${File}".md
echo -e "Created [$(date +%Y-%m-%d)]()\n" >> "${File}".md
echo -e "${tags} " >> "${File}".md
echo -e "- [X] **${File}** [README](README.md)" >> "${File}".md
echo -e "    - [X] Doing" >> "${File}".md
echo -e "    - [X] Backlog" >> "${File}".md
echo -e "       - [ ] " >> "${File}".md
echo -e "\n## Features" >> "${File}".md
echo -e "\n## Informations" >> "${File}".md

echo -e "\n## Main Program" >> "${File}".md

echo -e "*run-cell.sh*" >> "${File}".md
echo -e "\`\`\`bash" >> "${File}".md
echo -e "noweb.py -R${Filename}.${extens} ${File}.md > ${Filename}.${extens} && echo 'fertig' \n\`\`\`" >> "${File}".md

echo -e "\n\n\`\`\`bash" >> "${File}".md
echo -e "chmod u+x ${Filename}.${extens} && ln -sf "$folder"/${Filename}.${extens} ~/.local/bin/${Filename}.${extens} && echo 'fertig'\n \`\`\`" >> "${File}".md

echo -e "\n*${Filename}.${extens}*" >> "${File}".md
echo -e "\`\`\`${langname}" >> "${File}".md
# echo -e "\n@" >> "${File}".md
echo -e "\`\`\`" >> "${File}".md

touch ${Filename}.${extens}
```

### git versioning

*git init*
```bash
git init
git add README.md
git add "${File}".md
git add ${Filename}.${extens}
git commit -a -m "init git"
```