#!/bin/bash
File=$(echo $1)
abfrage=$(yad --title="New plantuml?" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Filename" \
	"Diagramm")
if [ ! $? -eq 1 ];
then
    Filename=$(echo $abfrage | cut -s -d "~" -f 1)
    echo -e "{{../${Filename}.png?width=500}}\n![](${Filename}.png?)\n"
    echo -e "\n*{Filename}.plantuml*"
    echo -e "\`\`\`pl"
    echo -e "@startuml\n allowmixing\n"
    echo -e "@enduml"
#    echo -e "\n@"
    echo -e "\`\`\`\n\n"
    echo -e "*run-cell.sh*"
    echo -e "\`\`\`bash"
    echo -e "noweb.py -R${Filename}.plantuml $(basename ${File}) > ${Filename}.plantuml && plantuml ${Filename}.plantuml && gwenview ${Filename}.png 2>/dev/null \n\`\`\`"
fi
