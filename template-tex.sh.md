# template-tex.sh
Created [2023-10-29]()

- [X] **template-tex.sh** [README.md](README.md)
    - [X] Doing
    - [X] Backlog

## Features

preamble from master thesis


## Informations
Christian Gößl
tex dateien mit markdown erstellen

Problem ist texstudio zu sagen wie es zu kompilieren ist

es ist möglich in texstudio andere Pfade fürs kompilieren zu geben

Kombination mit dem tt Programm und dann die Spezifikation ausarbeiten, damit es
auch mit zim zusammen funktioniert.


## Main Program

```bash
noweb.py -Rtemplate-tex.sh template-tex.sh.md > template-tex.sh && echo 'fertig' 
```


```bash
chmod u+x template-tex.sh && ln -sf /home/christian/Gedankenspeicher/KanDo/GedankenspeicherEinrichtung/GedankenspeicherCoding/template-tex.sh ~/.local/bin/template-tex.sh && echo 'fertig'
 ```

```bash
{{template-tex.sh}}=
{{preamble}}

if [[ ! -e "$1" ]]
then
    folder=$(pwd)
else
    filetxt=$(readlink -f -n "$1")
    folder=${filetxt%.*}
    mkdir -p "$folder"
fi
cd $folder
{{Main}}
@
```


### Preamble

presets bevor starting the program
the first line is needed for shell scripts

```bash
{{preamble}}=
#!/bin/bash
@
```

### Request

```bash
{{request}}=
abfrage=$(yad --title="New Latex File" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Filename" \
	--field="Author":CBE \
	--field="Tags":CBE \
	--field="Description":TXT \
    "Filename" "Christian Gößl,Internet" ",physic,math" "$additiontext")
@

```

### Main


```bash
{{Main}}=

{{request}}
if [ ! $? -eq 1 ];
then
	File=$(echo $abfrage | cut -s -d "~" -f 1)
	source=$(echo $abfrage | cut -s -d "~" -f 2)
	tags=$(echo $abfrage | cut -s -d "~" -f 3)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 4)
	File=$(echo "$File" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')

    foldertex="$File"_tex_folder
	mkdir -p "$foldertex"
    cp ~/Gedankenspeicher/Vorlagen/general-preamble.tex "$foldertex"/general-preamble.tex
    cp ~/Gedankenspeicher/Vorlagen/color-symbols.tex "$foldertex"/color-symbols.tex
    cd "$foldertex"


    #Filename="$File"
    #File="$File".tex



    {{description file}}

    {{tex template}}

    {{git init}}

fi

@

```

### create description file


```bash
{{description file}}=
echo -e "====== $foldertex ======" >> ../"$foldertex".md
echo -e "Created $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")" >> ../"$foldertex".md
echo -e "[*] ** $foldertex **" >> ../"$foldertex".md
echo -e "Folder for the latex file" >> ../"$foldertex".md
echo -e "[[./"${File}".md]]\n[[./"${File}".tex]]\n[[./"${File}".pdf]]" >> ../"$foldertex".md
@

```


### create Template

Creation of templates

```bash
{{tex template}}=
echo -e "# ${File}.tex" >> "${File}".md
echo -e "Created [$(date +%Y-%m-%d)]()\n" >> "${File}".md
echo -e "- [X] **${File}.tex** " >> "${File}".md
echo -e "    - [X] Doing" >> "${File}".md
echo -e "    - [X] Backlog" >> "${File}".md
echo -e "       - [ ] " >> "${File}".md
echo -e "\n## Features" >> "${File}".md
echo -e "\n## Informations" >> "${File}".md
echo -e "\n## Latex File\n" >> "${File}".md
echo -e "\n\`\`\`bash" >> "${File}".md
echo -e "noweb.py -R${File}.tex ${File}.md > ${File}.tex && pdflatex ${Filename}.tex && xdg-open ${File}.pdf 2>/dev/null & \n\`\`\`\n\n" >> "${File}".md
echo -e "\`\`\`tex" >> "${File}".md
echo -e "{{${File}.tex}}=" >> "${File}".md
echo -e "\\documentclass[10pt,fleqn,reqno,a4paper]{article}" >> "${File}".md
echo -e "\\input{general-preamble.tex}\n\\input{color-symbols.tex}" >> "${File}".md
echo "\begin{document}%\selectlanguage{english}" >> "${File}".md
echo -e "\n\n" >> "${File}".md
echo "\end{document}" >> "${File}".md
echo -e "\n@" >> "${File}".md
echo -e "\`\`\`" >> "${File}".md
touch ${File}.tex
@

```

### git versioning

```bash
{{git init}}=
git init
git add "${File}".md
git add ${File}.tex
git add general-preamble.tex
git add color-symbols.tex
git commit -a -m "init git"

@
```


