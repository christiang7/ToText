#!/bin/bash
folder="$(pwd)"
       File="Program"
       extens="sh"
       langname="bash"
       abfrage=$(zenity --forms \
              --width 500 \
              --title "New Program?" \
              --text "Necessary Informations:" \
              --add-entry "Filename" --add-entry "Extension" --add-entry "Shortname for language")

       if [ ! $? -eq 1 ];
       then

              if [[ ! "$abfrage" = "" ]];
              then
                     File=$(echo $abfrage | cut -s -d "|" -f 1)
                     extens=$(echo $abfrage | cut -s -d "|" -f 2)
                     langname=$(echo $abfrage | cut -s -d "|" -f 3)
              fi

              File=$(echo "$File" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')

              source="Christian Gößl"
              tags=$(echo "$3")
              additiontext=$(echo "$4")

              abfrage=$(zenity --forms \
                     --width 500 \
                     --title "Noch etwas hinzufügen?" \
                     --text "Noch etwas hinzufügen?" \
                     --add-entry "Quelle Standard: Christian Gößl" --add-entry "Schlagwörter" --add-entry "Weiteres")
              if [[ ! "$abfrage" = "" ]];
              then
                     source=$(echo $abfrage | cut -s -d "|" -f 1)
                     tags=$(echo $abfrage | cut -s -d "|" -f 2)
                     additiontext=$(echo $abfrage | cut -s -d "|" -f 3)
              fi

              echo -e "# ${File}" >> "${folder}"/"${File}".md
              echo -e "Created [[$(date +%Y-%m-%d)]]" >> "${folder}"/"${File}".md
              echo -e "- [X] ${tags} **${File}** ${source} [README.md](README.md)" >> "${folder}"/"${File}".md
              echo -e "   - [X] Doing" >> "${folder}"/"${File}".md
              echo -e "   - [X] Backlog" >> "${folder}"/"${File}".md
              echo -e "\n## Features" >> "${folder}"/"${File}".md
              echo -e "\n${additiontext}" >> "${folder}"/"${File}".md
              echo -e "\n\`\` noweb.py -R${File}.${extens} ${File}.md > ${File}.${extens} && echo 'fertig' \`\`" >> "${folder}"/"${File}".md
              echo -e "\n\n\`\` chmod u+x ${File}.${extens} && ln -sf "${folder}"/${File}.${extens} ~/.local/bin/${File}.${extens} && echo 'fertig' \`\`" >> "${folder}"/"${File}".md
              echo -e "\n\`\`\`${langname}" >> "${folder}"/"${File}".md
              echo -e "{{${File}.${extens}}}=" >> "${folder}"/"${File}".md
              echo -e "\n@" >> "${folder}"/"${File}".md
              echo -e "\n\`\`\`" >> "${folder}"/"${File}".md


       fi

