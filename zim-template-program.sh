#!/bin/bash
if zenity --question --text="Möchten Sie ein neues Programm schreiben?"
then
txtFile=$(echo "$1")
folder=${txtFile%.*}
mkdir -p "$folder"
cd "$folder"
filetxt=$(echo $2)
filepath=$(echo "${filetxt%/*}" | sed "s,/home/christian,~,")
wikipath=$(echo $filepath | sed "s,~/Gedankenspeicher/Gedankenspeicherwiki/,," | sed "s,/,:,g")
FullFilename=$(basename $filetxt .txt)
File=$(zenity --entry \
       --width 500 \
       --title "Type new filename" \
       --text "Enter new filename" \
       --entry-text "")
extens=$(zenity --entry \
       --width 500 \
       --title "Type new filename" \
       --text "Enter new filename" \
       --entry-text "sh")

File=$(echo "$File" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')

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

echo "Content-Type: text/x-zim-wiki" > "${folder}"/"${File}".txt
echo "Wiki-Format: zim 0.6" >> "${folder}"/"${File}".txt
echo -e "===== ${File} =====" >> "${folder}"/"${File}".txt
echo -e "Created $(date +"%A") $(date +[[Zettelkasten:%Y:%m:%d]])" >> "${folder}"/"${File}".txt
echo -e "Backlink [[$wikipath:$FullFilename]]" >> "${folder}"/"${File}".txt
#"${filepath}.txt
#echo -e "$([[Zettelkasten:%Y:%m:%d]])" >> "${folder}"/"${File}".txt
echo -e "[[../]]" >> "${folder}"/"${File}".txt
echo -e "[*] ${tags} ** ${File} ** >  2277-11-11" >> "${folder}"/"${File}".txt
echo -e "\n${additiontext}" >> "${folder}"/"${File}".txt
echo -e "\n''noweb.py -R${File}.${extens} ${File}.txt > ${File}.${extens} && chmod u+x ${File}.${extens} && ln -sf "${folder}"/${File}.${extens} ~/.local/bin/${File}.${extens} && echo 'fertig'''" >> "${folder}"/"${File}".txt
echo -e "\n{{{code: lang="sweave" linenumbers="True"" >> "${folder}"/"${File}".txt
echo -e "<<${File}.${extens}>>=" >> "${folder}"/"${File}".txt
echo -e "\n@" >> "${folder}"/"${File}".txt
echo -e "\n}}}" >> "${folder}"/"${File}".txt

echo -e "\n[[+${File}]]" >> "${filetxt}.txt"

fi
