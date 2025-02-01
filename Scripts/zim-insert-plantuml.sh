#!/bin/bash
File=$(echo $1)
abfrage=$(yad --title="New plantuml?" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Filename" \
	"Diagramm")
if [ ! $? -eq 1 ];
then
    Filename=$(echo $abfrage | cut -s -d "~" -f 1)
    echo -e "{{../Notedia-${Filename}.png?width=500}}\n![](Notedia-${Filename}.png?)\n"
    echo -e "\n*Notedia-{$Filename}.plantuml*"
    echo -e "\`\`\`pl"
    echo -e "@startuml\n allowmixing\n"
    echo -e "@enduml"
#    echo -e "\n@"
    echo -e "\`\`\`\n\n"
    echo -e "*run-cell.sh*"
    echo -e "\`\`\`bash"
    echo -e "noweb.py -RNotedia-${Filename}.plantuml $(basename ${File}) > Notedia-${Filename}.plantuml && plantuml Notedia-${Filename}.plantuml && gwenview Notedia-${Filename}.png 2>/dev/null \n\`\`\`"
fi
