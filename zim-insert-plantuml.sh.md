# zim-insert-plantuml.sh
Created [2024-09-03](2024-09-03)

- [X] **zim-insert-plantuml.sh**
    - [X] Doing
    - [X] Backlog

## Features



## Informations
 Christian Gößl
## Main Program

```bash
{{run-cell.sh}}=
noweb.py -Rzim-insert-plantuml.sh zim-insert-plantuml.sh.md > zim-insert-plantuml.sh && echo 'fertig' 
@
```


```bash
chmod u+x zim-insert-plantuml.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/Gedankenspeicher-Coding/zim-insert-plantuml.sh ~/.local/bin/zim-insert-plantuml.sh && echo 'fertig'
 ```

```bash
{{zim-insert-plantuml.sh}}=
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
    echo -e "\n\`\`\`plantuml"
    echo -e "{{${Filename}.plantuml}}="
    echo -e "  @startuml\n allowmixing\n"
    echo -e "  @enduml"
    echo -e "\n@"
    echo -e "\`\`\`\n\n"
    echo -e "\n\`\`\`bash"
    echo -e "{{run-cell.sh}}="
    echo -e "noweb.py -R${Filename}.plantuml $(basename ${File}) > ${Filename}.plantuml && plantuml ${Filename}.plantuml && gwenview ${Filename}.png 2>/dev/null \n@\n\`\`\`"
fi
@
```
