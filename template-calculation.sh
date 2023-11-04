#!/bin/bash
yad --title="New calculation?" --text="\n Standalone File?\n"
if [ ! $? -eq 1 ];
then
  if [[ ! -e "$1" ]]
  then
    folder=$(pwd)
    #echo $folder
  else
    filetxt=$(readlink -f -n "$1")
    folder=${filetxt%.*}
    #echo $folder
    mkdir -p "$folder"
  fi
  File="Filename"
  cd $folder
  abfrage=$(yad --title="New calculation?" --text="Necessary Informations:" \
  	--form --width 500 --separator="~" --item-separator=","  \
  	--field="Filename" \
  	--field="Shortname for language":CB \
  	--field="Author":CBE \
  	--field="Tags":CBE \
  	--field="Description":TXT \
  	"$File" "cpp,python,julia,html,css,javascript,bash,lua,other" "Christian Gößl,Internet" ",physic,math" "$additiontext")
  if [ ! $? -eq 1 ];
  then
  	File=$(echo $abfrage | cut -s -d "~" -f 1)
  	langname=$(echo $abfrage | cut -s -d "~" -f 2)
  	source=$(echo $abfrage | cut -s -d "~" -f 3)
  	tags=$(echo $abfrage | cut -s -d "~" -f 4)
  	additiontext=$(echo $abfrage | cut -s -d "~" -f 5)
  	File=$(echo "$File" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')

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

      echo -e "# ${File}" >> "${File}".md
      echo -e "Created [$(date +%Y-%m-%d)]($(date +%Y-%m-%d))" >> "${File}".md
      echo -e "${tags}" >> "${File}".md
      echo -e "- [X] **${File}**" >> "${File}".md
      echo -e "    - [X] Doing" >> "${File}".md
      echo -e "    - [X] Backlog" >> "${File}".md
      echo -e "\n## Features" >> "${File}".md
      echo -e "\n${additiontext}" >> "${File}".md
      echo -e "\n## Informations" >> "${File}".md
      echo -e " ${source}\n## Main Program" >> "${File}".md
      echo -e "\n\`\`\`bash" >> "${File}".md
      echo -e "noweb.py -R${Filename}.${extens} ${File}.md > ${Filename}.${extens} && echo 'fertig' \n\`\`\`" >> "${File}".md
      echo -e "\n\n\`\`\`bash" >> "${File}".md
      echo -e "chmod u+x ${Filename}.${extens} && ln -sf "${folder}"/${Filename}.${extens} ~/.local/bin/${Filename}.${extens} && echo 'fertig'\n \`\`\`" >> "${File}".md
      echo -e "\n\`\`\`${langname}" >> "${File}".md
      echo -e "{{${Filename}.${extens}}}=" >> "${File}".md
      echo -e "\n@" >> "${File}".md
      echo -e "\`\`\`" >> "${File}".md
      touch ${File}
  fi
else
  zim-template-calculation.sh "$1"
  #echo 2
fi

