#!/bin/bash
yad --title="New calculation?" --text="Standalone File?\n\n"
if [ ! $? -eq 1 ];
then
  folder=$(pwd)
  File="Filename"
  abfrage=$(yad --title="New calculation?" --text="Necessary Informations:" \
  	--form --width 500 --separator="~" --item-separator=","  \
  	--field="Filename" \
  	--field="Shortname for language":CB \
  	--field="Author":CBE \
  	--field="Tags":CBE \
  	--field="Description":TXT \
  	"$File" "python,julia,html,css,javascript,bash,lua,other" "Christian Gößl,Internet" "physic,math" "$additiontext")
  if [ ! $? -eq 1 ];
  then
  	File=$(echo $abfrage | cut -s -d "~" -f 1)
  	langname=$(echo $abfrage | cut -s -d "~" -f 2)
  	source=$(echo $abfrage | cut -s -d "~" -f 3)
  	tags=$(echo $abfrage | cut -s -d "~" -f 4)
  	additiontext=$(echo $abfrage | cut -s -d "~" -f 5)
  	File=$(echo "$File" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')

  	case ${langname} in
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

      echo -e "# ${File}" >> "${folder}"/"${File}".md
      echo -e "Created [$(date +%Y-%m-%d)]($(date +%Y-%m-%d))" >> "${folder}"/"${File}".md
      echo -e "${tags}" >> "${folder}"/"${File}".md
      echo -e "- [X] **${File}**" >> "${folder}"/"${File}".md
      echo -e "    - [X] Doing" >> "${folder}"/"${File}".md
      echo -e "    - [X] Backlog" >> "${folder}"/"${File}".md
      echo -e "\n## Features" >> "${folder}"/"${File}".md
      echo -e "\n${additiontext}" >> "${folder}"/"${File}".md
      echo -e "\n## Informations" >> "${folder}"/"${File}".md
      echo -e " ${source}\n## Main Program" >> "${folder}"/"${File}".md
      echo -e "\n\`\`\`bash" >> "${folder}"/"${File}".md
      echo -e "noweb.py -R${Filename}.${extens} ${File}.md > ${Filename}.${extens} && echo 'fertig' \n\`\`\`" >> "${folder}"/"${File}".md
      echo -e "\n\n\`\`\`bash" >> "${folder}"/"${File}".md
      echo -e "chmod u+x ${Filename}.${extens} && ln -sf "${folder}"/${Filename}.${extens} ~/.local/bin/${Filename}.${extens} && echo 'fertig'\n \`\`\`" >> "${folder}"/"${File}".md
      echo -e "\n\`\`\`${langname}" >> "${folder}"/"${File}".md
      echo -e "{{${Filename}.${extens}}}=" >> "${folder}"/"${File}".md
      echo -e "\n@" >> "${folder}"/"${File}".md
      echo -e "\`\`\`" >> "${folder}"/"${File}".md
      touch "${folder}"/${File}
  fi
else
  zim-template-calculation.sh "$1"
fi

