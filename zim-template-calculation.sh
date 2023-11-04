#!/bin/bash

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

    if [[ ! -e ../"$Project".md ]]
    then
    folder="$Project"
    #touch ../"$folder".md
    echo -e "====== $ProjectName ======" >> ../"$folder".md
    echo -e "Created $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")" >> ../"$folder".md
    echo -e "[*] ** $folder **" >> ../"$folder".md
    fi

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
    #README template
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
    echo -e "\n\`\`\`bash" >> "${File}".md
    echo -e "noweb.py -R${Filename}.${extens} ${File}.md > ${Filename}.${extens} && echo 'fertig' \n\`\`\`" >> "${File}".md
    echo -e "\n\n\`\`\`bash" >> "${File}".md
    echo -e "chmod u+x ${Filename}.${extens} && ln -sf "$folder"/${Filename}.${extens} ~/.local/bin/${Filename}.${extens} && echo 'fertig'\n \`\`\`" >> "${File}".md
    echo -e "\n\`\`\`${langname}" >> "${File}".md
    echo -e "{{${Filename}.${extens}}}=" >> "${File}".md
    echo -e "\n@" >> "${File}".md
    echo -e "\`\`\`" >> "${File}".md
    touch ${Filename}.${extens}

    git init
    git add README.md
    git add "${File}".md
    git add ${Filename}.${extens}
    git commit -a -m "init git"


fi

