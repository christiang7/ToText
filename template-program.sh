#!/bin/bash

if [[ ! -e "$1" ]]
then
  folder=$(pwd)
  abfrage=$(yad --title="New Program?" --text="Necessary Informations:" \
  	--form --width 500 --separator="~" --item-separator=","  \
  	--field="Filename" \
  	--field="Shortname for language":CBE \
  	--field="Extension":CBE \
  	--field="Author":CBE \
  	--field="Tags":CBE \
  	--field="Description":TXT \
  	"$File" "bash,python,julia,html,css,javascript" "sh,py,jl,html,css,js" "Christian Gößl,Internet" ",physic,math" "$additiontext")
  if [ ! $? -eq 1 ];
  then
  	File=$(echo $abfrage | cut -s -d "~" -f 1)
  	langname=$(echo $abfrage | cut -s -d "~" -f 2)
  	extens=$(echo $abfrage | cut -s -d "~" -f 3)
  	source=$(echo $abfrage | cut -s -d "~" -f 4)
  	tags=$(echo $abfrage | cut -s -d "~" -f 5)
  	additiontext=$(echo $abfrage | cut -s -d "~" -f 6)
  	File=$(echo "$File" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
      echo -e "# ${File}" >> "${folder}"/"${File}".md
      echo -e "Created [$(date +%Y-%m-%d)]()\n" >> "${folder}"/"${File}".md
      echo -e "- [X] ${tags} **${File}** ${source} [README.md](README.md)" >> "${folder}"/"${File}".md
      echo -e "    - [X] Doing" >> "${folder}"/"${File}".md
      echo -e "    - [X] Backlog" >> "${folder}"/"${File}".md
      echo -e "\n## Features" >> "${folder}"/"${File}".md
      echo -e "\n${additiontext}" >> "${folder}"/"${File}".md
      echo -e "\n## Informations" >> "${folder}"/"${File}".md
      echo -e "\n## Main Program" >> "${folder}"/"${File}".md
      echo -e "\n\`\`\`bash\nnoweb.py -R${File}.${extens} ${File}.md > ${File}.${extens} && echo 'fertig' \n\`\`\`" >> "${folder}"/"${File}".md
      echo -e "\n\n\`\`\`bash\nchmod u+x ${File}.${extens} && ln -sf "${folder}"/${File}.${extens} ~/.local/bin/${File}.${extens} && echo 'fertig'\n \`\`\`" >> "${folder}"/"${File}".md
      echo -e "\n\`\`\`${langname}" >> "${folder}"/"${File}".md
      echo -e "{{${File}.${extens}}}=" >> "${folder}"/"${File}".md
      echo -e "\n@" >> "${folder}"/"${File}".md
      echo -e "\n\`\`\`" >> "${folder}"/"${File}".md
  fi
else
  zim-template-program.sh "$1"
fi

