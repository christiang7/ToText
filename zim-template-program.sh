#!/bin/bash
txtFile=$(echo "$1")
folder=${txtFile%.*}
mkdir -p "$folder"
cd "$folder"
filetxt=$(echo $2)
filepath=$(echo "${filetxt%/*}" | sed "s,/home/christian,~,")
wikipath=$(echo $filepath | sed "s,~/Gedankenspeicher/Gedankenspeicherwiki/,," | sed "s,/,:,g")
FullFilename=$(basename $filetxt .txt)
File="Program"
extens="sh"

abfrage=$(zenity --forms \
       --width 500 \
       --title "New Program?" \
       --text "Necessary Informations:" \
       --add-entry "Filename" --add-entry "Extension Standard sh")

if [ ! $? -eq 1 ];
then

if [[ ! "$abfrage" = "" ]];
then
	File=$(echo $abfrage | cut -s -d "|" -f 1)
	extens=$(echo $abfrage | cut -s -d "|" -f 2)
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

echo "Content-Type: text/x-zim-wiki" > "${folder}"/"${File}".txt
echo "Wiki-Format: zim 0.6" >> "${folder}"/"${File}".txt
echo -e "===== ${File} =====" >> "${folder}"/"${File}".txt
echo -e "Created $(date +[[Zettelkasten:%Y:%m:%d]])" >> "${folder}"/"${File}".txt
echo -e "Backlink [[$wikipath:$FullFilename]]" >> "${folder}"/"${File}".txt
#"${filepath}.txt
#echo -e "$([[Zettelkasten:%Y:%m:%d]])" >> "${folder}"/"${File}".txt
echo -e "[[../]]" >> "${folder}"/"${File}".txt
echo -e "[*] ${tags} ** ${File} ** ${source} >  2277-11-11" >> "${folder}"/"${File}".txt
echo -e "\n${additiontext}" >> "${folder}"/"${File}".txt
echo -e "\n''noweb.py -R${File}.${extens} ${File}.txt > ${File}.${extens} && echo 'fertig'''" >> "${folder}"/"${File}".txt
echo -e "\n\n''chmod u+x ${File}.${extens} && ln -sf "${folder}"/${File}.${extens} ~/.local/bin/${File}.${extens} && echo 'fertig'''" >> "${folder}"/"${File}".txt
echo -e "\n{{{code: lang="sweave" linenumbers="True"" >> "${folder}"/"${File}".txt
echo -e "<<${File}.${extens}>>=" >> "${folder}"/"${File}".txt
echo -e "\n@" >> "${folder}"/"${File}".txt
echo -e "\n}}}" >> "${folder}"/"${File}".txt

echo -e "\n[[+${File}]]" >> "${filetxt}.txt"

fi
