#!/usr/bin/env bash


if [[ ! -e "$1" ]]
then
	folder=$(pwd)
	echo $folder
else
  folder=$(echo "$1")
  echo $folder
fi

Newname=$(zenity --entry \
       --width 500 \
       --title "Welcher Dateiname?" \
       --text "Welcher Dateiname?" \
       --entry-text "$filename")
File=$(echo "$Newname" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g'|  sed 's/&/n/g' | sed 's/\///g' | sed 's/|//g' | sed 's/\[/(/g' | sed 's/\]/)/g' | sed 's/@/at/g')

#extens=${f##*.}
#zimpath="${folder}"

source=$(zenity --entry \
       --width 500 \
       --title "Noch eine Quelle hinzufügen?" \
       --text "Noch eine Quelle hinzufügen?" \
       --entry-text "Christian Gößl")
tags=$(zenity --entry \
       --width 500 \
       --title "Noch Schlagwörter hinzufügen?" \
       --text "Noch Schlagwörter hinzufügen?" \
       --entry-text "${3}@")
additiontext=$(zenity --entry \
       --width 500 \
       --title "Noch etwas hinzufügen?" \
       --text "Noch etwas hinzufügen?" \
       --entry-text "$4")


mkdir -p "${folder}"/"${File}"
echo "Content-Type: text/x-zim-wiki" > "${folder}"/"${File}".txt
echo "Wiki-Format: zim 0.6" >> "${folder}"/"${File}".txt
echo -e "===== ${File} =====" >> "${folder}"/"${File}".txt
echo -e "Created $(date +"%A") $(date +[[Zettelkasten:%Y:%m:%d]])" >> "${folder}"/"${File}".txt
#echo -e "Backlink $([[Zettelkasten:%Y:%m:%d]])" >> "${folder}"/"${File}".txt
echo -e "[[../]]" >> "${folder}"/"${File}".txt
echo -e "[*] ${tags} ** ${File} ** >  2277-11-11" >> "${folder}"/"${File}".txt
echo -e "\n${additiontext}" >> "${folder}"/"${File}".txt
#echo -e "\n${tabs}" >> "${folder}"/"${File}".txt

