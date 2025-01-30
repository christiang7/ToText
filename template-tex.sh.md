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


```bash
chmod u+x template-tex.sh && ln -sf /home/christian/Gedankenspeicher/KanDo/GedankenspeicherEinrichtung/GedankenspeicherCoding/template-tex.sh ~/.local/bin/template-tex.sh && echo 'fertig'
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
```

### Request

*request*
```bash
abfrage=$(yad --title="New Latex File" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Filename:" \
	--field="Which template:":CB \
	--field="Shortname for language":CB \
	--field="Author:":CBE \
	--field="Tags:":CBE \
	--field="Git init?":CB \
	--field="Description:":TXT \
	"Filename" "Programming,normal,Rechnung,Schreiben,Bewerbung" "cpp,python,julia,html,css,javascript,bash,lua,other" "Christian Gößl,Internet" ",physic,math" "No,Yes" "$additiontext")
```

### Main


*Main*
```bash

#*request}}

if [ ! $? -eq 1 ];
then
	File=$(echo $abfrage | cut -s -d "~" -f 1)
	template=$(echo $abfrage | cut -s -d "~" -f 2)
	langname=$(echo $abfrage | cut -s -d "~" -f 3)
	source=$(echo $abfrage | cut -s -d "~" -f 4)
	tags=$(echo $abfrage | cut -s -d "~" -f 5)
	gitinit=$(echo $abfrage | cut -s -d "~" -f 6)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 7)
	title="$File"
	File=$(echo "$File" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')

	foldertex="$File"_tex
	mkdir -p "$foldertex"
	cp ~/Gedankenspeicher/Vorlagen/general-preamble.tex "$foldertex"/general-preamble.tex
	cp ~/Gedankenspeicher/Vorlagen/color-symbols.tex "$foldertex"/color-symbols.tex
	cd "$foldertex"

	#Filename="$File"
	#File="$File".tex

	#*description file}}

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
			#*programming tex template}}
			;;
	esac
	if [[ $gitinit == "Yes" ]];
	then
		#*git init}}
	fi

fi
```

### create description file


*description file*
```bash
echo -e "====== $foldertex ======" >> ../"$foldertex".md
echo -e "Created $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")" >> ../"$foldertex".md
echo -e "[*] ** $foldertex **" >> ../"$foldertex".md
echo -e "Folder for the latex file" >> ../"$foldertex".md
echo -e "[[./"${File}".md]]\n[[./"${File}".tex]]\n[[./"${File}".pdf]]" >> ../"$foldertex".md
```


### create programming template

Creation of template

*programming tex template*
```bash
echo -e "# ${title}" >> "${File}".md
echo -e "Created [$(date +%Y-%m-%d)]()\n" >> "${File}".md
echo -e "- [X] **${title}** " >> "${File}".md
echo -e "    - [X] Doing" >> "${File}".md
echo -e "    - [X] Backlog" >> "${File}".md
echo -e "       - [ ] " >> "${File}".md
echo -e "\n## Features" >> "${File}".md
echo -e "\n## Informations" >> "${File}".md

echo -e "\n## Programming" >> "${File}".md

echo -e "\n*run-cell.sh*" >> "${File}".md
echo -e "\`\`\`bash" >> "${File}".md
echo -e "noweb.py -R${File}.${extens} ${File}.md > ${File}.${extens} && noweb.py -R${File}.tex ${File}.md > ${File}.tex && pdflatex -shell-escape ${File}.tex && echo '${File}.tex' && date \n\`\`\`" >> "${File}".md

echo -e "\n*${File}.${extens}*" >> "${File}".md
echo -e "\`\`\`${extens}" >> "${File}".md
echo -e "\n\`\`\`" >> "${File}".md

echo -e "\n## Latex File\n" >> "${File}".md

echo -e "\n\`\`\`bash" >> "${File}".md
echo -e "noweb.py -R${File}.tex ${File}.md > ${File}.tex && pdflatex -shell-escape ${File}.tex && echo '${File}.tex' && date && xournalpp ${File}.pdf 2>/dev/null & \n\`\`\`\n\n" >> "${File}".md

echo -e "*${File}.tex*" >> "${File}".md
echo -e "\`\`\`latex" >> "${File}".md
echo -e "\\documentclass[10pt,fleqn,reqno,a4paper]{article}" >> "${File}".md
echo -e "\\input{general-preamble.tex}\n\\input{color-symbols.tex}" >> "${File}".md
echo "\begin{document}%\selectlanguage{english}" >> "${File}".md
echo -e "\n\n" >> "${File}".md
echo "\begin{minted}[linenos=true,bgcolor=lightgraycolor,numberblanklines=true,showspaces=false,breaklines=true]{${langname}}" >> "${File}".md
echo "#*${File}.${extens}}}" >> "${File}".md
echo "\end{minted}" >> "${File}".md
echo "\end{document}" >> "${File}".md
# echo "@" >> "${File}".md
echo -e "\`\`\`" >> "${File}".md

echo -e "[[./"${File}".${extens}]]" >> ../"$foldertex".md
touch ${File}.tex
noweb.py -R${File}.tex ${File}.md > ${File}.tex
noweb.py -R${File}.${extens} ${File}.md > ${File}.${extens}
```


### create normal template

Creation of templates

*normal tex template*
```bash
echo -e "# ${File}.tex" >> "${File}".md
echo -e "Created [$(date +%Y-%m-%d)]()\n" >> "${File}".md
echo -e "- [X] **${File}.tex** " >> "${File}".md
echo -e "    - [X] Doing" >> "${File}".md
echo -e "    - [X] Backlog" >> "${File}".md
echo -e "       - [ ] " >> "${File}".md
echo -e "\n## Features" >> "${File}".md
echo -e "\n## Informations" >> "${File}".md

echo -e "\n## Latex File\n" >> "${File}".md

echo -e "\n*run-cell.sh*" >> "${File}".md
echo -e "\`\`\`bash" >> "${File}".md
echo -e "noweb.py -R${File}.tex ${File}.md > ${File}.tex && pdflatex -shell-escape ${File}.tex && echo '${File}.tex' && date && xournalpp ${File}.pdf 2>/dev/null &\n\`\`\`\n\n" >> "${File}".md

echo -e "*${File}.tex*" >> "${File}".md
echo -e "\`\`\`latex" >> "${File}".md
echo -e "\\documentclass[10pt,fleqn,reqno,a4paper]{article}" >> "${File}".md
echo -e "\\input{general-preamble.tex}\n\\input{color-symbols.tex}" >> "${File}".md
echo -e "\begin{document}%\selectlanguage{english}" >> "${File}".md
echo -e "\n\n" >> "${File}".md
echo -e "\end{document}" >> "${File}".md
# echo -e "\n@" >> "${File}".md
echo -e "\`\`\`" >> "${File}".md

touch ${File}.tex
noweb.py -R${File}.tex ${File}.md > ${File}.tex
```


### create Rechnung template

Creation of Rechnung template

*Rechnung tex template*
```bash
echo -e "# ${File}.tex" >> "${File}".md
echo -e "Created [$(date +%Y-%m-%d)]()\n" >> "${File}".md
echo -e "- [X] **${File}.tex** " >> "${File}".md
echo -e "    - [X] Doing" >> "${File}".md
echo -e "    - [X] Backlog" >> "${File}".md
echo -e "       - [ ] " >> "${File}".md
echo -e "\n## Features" >> "${File}".md
echo -e "\n## Informations" >> "${File}".md

echo -e "\n## Latex File\n" >> "${File}".md

echo -e "\n*run-cell.sh*" >> "${File}".md
echo -e "\`\`\`bash" >> "${File}".md
echo -e "noweb.py -R${File}.tex ${File}.md > ${File}.tex && pdflatex -shell-escape ${File}.tex && echo '${File}.tex' && date && xournalpp ${File}.pdf 2>/dev/null & \n\`\`\`\n\n" >> "${File}".md

echo -e "*${File}.tex*" >> "${File}".md
echo -e "\`\`\`latex" >> "${File}".md
cat /home/christian/Gedankenspeicher/Vorlagen/Rechnung-Vorlage.tex >> "${File}".md
# echo -e "\n@" >> "${File}".md
echo -e "\`\`\`" >> "${File}".md

touch ${File}.tex
noweb.py -R${File}.tex ${File}.md > ${File}.tex
```
### create Schreiben template

*Schreiben tex template*
```bash
echo -e "# ${File}.tex" >> "${File}".md
echo -e "Created [$(date +%Y-%m-%d)]()\n" >> "${File}".md
echo -e "- [X] **${File}.tex** " >> "${File}".md
echo -e "    - [X] Doing" >> "${File}".md
echo -e "    - [X] Backlog" >> "${File}".md
echo -e "       - [ ] " >> "${File}".md
echo -e "\n## Features" >> "${File}".md

echo -e "\n## Informations" >> "${File}".md

echo -e "\n## Latex File\n" >> "${File}".md

echo -e "\n*run-cell.sh*" >> "${File}".md
echo -e "\`\`\`bash" >> "${File}".md
echo -e "noweb.py -R${File}.tex ${File}.md > ${File}.tex && pdflatex -shell-escape ${File}.tex && echo '${File}.tex' && date && xournalpp ${File}.pdf 2>/dev/null & \n\`\`\`\n\n" >> "${File}".md

echo -e "*${File}.tex*" >> "${File}".md
echo -e "\`\`\`latex" >> "${File}".md
cat /home/christian/Gedankenspeicher/Vorlagen/Schreiben-Vorlagen.tex >> "${File}".md
# echo -e "\n@" >> "${File}".md
echo -e "\`\`\`" >> "${File}".md

touch ${File}.tex
noweb.py -R${File}.tex ${File}.md > ${File}.tex
```


### create Bewerbung template

Creation of Bewerbung template

*Bewerbung tex template*
```bash
echo -e "# ${File}.tex" >> "${File}".md
echo -e "Created [$(date +%Y-%m-%d)]()\n" >> "${File}".md
echo -e "- [X] **${File}.tex** " >> "${File}".md
echo -e "    - [X] Doing" >> "${File}".md
echo -e "    - [X] Backlog" >> "${File}".md
echo -e "       - [ ] " >> "${File}".md
echo -e "\n## Features" >> "${File}".md

echo -e "\n## Informations" >> "${File}".md

echo -e "\n## Latex File\n" >> "${File}".md

echo -e "\n*run-cell.sh*" >> "${File}".md
echo -e "\`\`\`bash" >> "${File}".md
echo -e "noweb.py -R${File}.tex ${File}.md > ${File}.tex && pdflatex -shell-escape ${File}.tex && echo '${File}.tex' && date && xournalpp ${File}.pdf 2>/dev/null & \n\`\`\`\n\n" >> "${File}".md

echo -e "*${File}.tex*" >> "${File}".md
echo -e "\`\`\`latex" >> "${File}".md
echo -e "\\documentclass[10pt,fleqn,reqno,a4paper]{article}" >> "${File}".md
echo -e "\\input{general-preamble.tex}\n\\input{color-symbols.tex}" >> "${File}".md
echo -e "\begin{document}%\selectlanguage{english}" >> "${File}".md
echo -e "\n\n" >> "${File}".md
echo -e "\end{document}" >> "${File}".md
# echo -e "\n@" >> "${File}".md
echo -e "\`\`\`" >> "${File}".md

touch ${File}.tex
noweb.py -R${File}.tex ${File}.md > ${File}.tex
```



### git versioning

*git init*
```bash
git init
git add "${File}".md
git add ${File}.tex
if [[ $template == "programming" ]];
then
	git add ${File}.${extens}
fi
git add general-preamble.tex
git add color-symbols.tex
git commit -a -m "init git"
```


