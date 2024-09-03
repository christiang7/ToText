#!/bin/bash
File=$(echo $1)
abfrage=$(yad --title="New plantuml?" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Filename" \
	"Diagramm")
if [ ! $? -eq 1 ];
then
    Filename=$(echo $abfrage | cut -s -d "~" -f 1)
    echo -e "{{../Schönheit-Diagramm.png?width=500}}\n\n"
    echo -e "\n\`\`\`plantuml"
    echo -e "{{${Filename}.plantuml}}="
    echo -e "  @startuml\n"
    echo -e "  @enduml"
    echo -e "\n@"
    echo -e "\`\`\`\n\n"
    echo -e "\n\`\`\`bash"
    echo -e "{{run-cell.sh}}="
    echo -e "noweb.py -R${Filename}.plantuml $(basename ${File}) > ${Filename}.plantuml && plantuml ${Filename}.plantuml && gwenview ${Filename}.png 2>/dev/null \n@\n\`\`\`"
fi
