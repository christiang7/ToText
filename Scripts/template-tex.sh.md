# template-tex.sh
Created [2023-10-29]()

 [README.md](README.md)
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



template for latex file for calculations or exercises for courses or papers

tex is the main file and from that the code can be exported to a program file

in

Break Lines in minted environment | AnonymousOverflow
https://overflow.adminforge.de/exchange/tex/questions/200310/break-lines-in-minted-environment


## Main Program

*run-cell.sh*
```bash
noweb.py -Rtemplate-tex.sh template-tex.sh.md > template-tex.sh && echo 'template-tex.sh' && date
```

*template-tex.sh*
```bash
#*preamble}}

if [[ ! -e "$1" ]]
then
	folder=$(pwd)
else
	filetxt=$(readlink -f -n "$1")
	folder=${filetxt%.*}
	mkdir -p "$folder"
fi
cd $folder

#*Main}}

```


### Preamble

setting presets before starting the program
the first line is needed for shell scripts

*preamble*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
templateDir="$(config_get templateDir)"
langName="$(config_get langName)"
source tt-lib.sh;
```

### Request

*request*
```bash
abfrage=$(yad --title="New Latex File" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Filename:" \
	--field="Which template:":CB \
	--field="Shortname for language":CBE \
	--field="Author:":CBE \
	--field="Tags:":CBE \
	--field="Git init?":CB \
	--field="Description:":TXT \
	"" "Programming,normal,Rechnung,Schreiben,Bewerbung" "$langName" "Christian Gößl,Internet" ",physic,math" "No,Yes" "$additiontext")
```

### Main


*Main*
```bash

#*request}}

if [ ! $? -eq 1 ];
then
	filename=$(echo $abfrage | cut -s -d "~" -f 1)
	template=$(echo $abfrage | cut -s -d "~" -f 2)
	langname=$(echo $abfrage | cut -s -d "~" -f 3)
	source=$(echo $abfrage | cut -s -d "~" -f 4)
	tags=$(echo $abfrage | cut -s -d "~" -f 5)
	gitinit=$(echo $abfrage | cut -s -d "~" -f 6)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 7)
	title="$filename"
	filename=$(cleanName "$filename")
	folder=.

	foldertex="$filename"_tex
	mkdir -p "$foldertex"
	cp $templateDir/general-preamble.tex "$foldertex"/general-preamble.tex
	cp $templateDir/color-symbols.tex "$foldertex"/color-symbols.tex
	if [[ ${template} == "Programming" ]]
	then
		extens="$(get-extens ${langname})"
		add="[[./"${filename}".${extens}]]\n"
	fi

	create-note "$folder" "$foldertex" "@LATEX $tags" "" "$add[[./$filename.md]]\n[[./$filename.tex]]\n[[./$filename.pdf]]"

	markdown-description-program "$folder/$foldertex" "${filename}"

	File="${filename}.tex"
	case ${template} in
		normal)
		#*normal tex template}}
			;;
        Rechnung)
		#*Rechnung tex template}}
			;;
        Bewerbung)
		#*Bewerbung tex template}}
            ;;
		Schreiben)
		#*Schreiben tex template}}
            ;;
		Programming)
		#*programming tex template}}
			;;
	esac
	if [[ $gitinit == "Yes" ]];
	then
		#*git init}}
	fi

fi
```


### create programming template

Creation of template

*programming tex template*
```bash

cp "$templateDir"/programming-template.tex "$folder"/"$foldertex"/"${File}"

tex-description "$folder" "${File}" "$foldertex" "$additiontext\n\\\begin{minted}[linenos=true,bgcolor=lightgraycolor,numberblanklines=true,showspaces=false,breaklines=true]{${langname}}\n#*${File}}}\n\\\end{minted}" "#*run program}}"

program-template "$folder/$foldertex" "${filename}.${extens}" "${filename}.tex"


```


### create normal template

Creation of templates

*normal tex template*
```bash
cp "$templateDir"/normal-template.tex "$folder"/"$foldertex"/"${File}"

tex-description "$folder" "${File}" "$foldertex" "$additiontext"
```



### create Rechnung template

Creation of Rechnung template

*Rechnung tex template*
```bash
cp "$templateDir"/Rechnung-template.tex "$folder"/"$foldertex"/"${File}"

tex-description "$folder" "${File}" "$foldertex" "$additiontext"

```


### create Schreiben template

*Schreiben tex template*
```bash
cp "$templateDir"/Schreiben-template.tex "$folder"/"$foldertex"/"${File}"

tex-description "$folder" "${File}" "$foldertex" "$additiontext"

```


### create Bewerbung template

Creation of Bewerbung template

*Bewerbung tex template*
```bash
cp "$templateDir"/normal-template.tex "$folder"/"$foldertex"/"${File}"

tex-description "$folder" "${File}" "$foldertex" "$additiontext"
```



### git versioning

*git init*
```bash
cd "$foldertex"

git init
git add "${filename}".md
git add "${filename}".tex
if [[ $template == "programming" ]];
then
	git add ${filename}.${extens}
fi
git add general-preamble.tex
git add color-symbols.tex
git commit -a -m "init git"
```


