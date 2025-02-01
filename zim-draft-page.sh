#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
inputDir="$(config_get inputDir)"
tempInputDir="$(config_get tempInputDir)"
templateDir="$(config_get templateDir)"


filenamexopp=$(date +"Draft_%Y-%m-%d".xopp)
touch "${filenamexopp}".md
echo "Content-Type: text/x-zim-wiki" > "${filenamexopp}".md
echo "Wiki-Format: zim 0.6" >> "${filenamexopp}".md
echo -e "====== $(date +"Draft %Y-%m-%d") ======" >> "${filenamexopp}".md
echo -e "Created $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]")" >> "${filenamexopp}".md
echo -e "[*] **[[../$filenamexopp]]** \n\n" >> "${filenamexopp}".md

oldfilename=$(date -d "yesterday 13:00" +"Draft_page_%Y-%m-%d")
oldfilenamexopp=$(date -d "yesterday 13:00" +"Draft_%Y-%m-%d".xopp)
#mv -f $inputDir/"${oldfilename}".md $tempInputDir/"${oldfilename}".md 2>/dev/null
#mv -f $inputDir/"${filename}".md $tempInputDir/"${filename}".md 2>/dev/null
#mv -f "${filename}".md $inputDir/"${filename}".md 2>/dev/null

mv -f $inputDir/"${oldfilenamexopp}".md $tempInputDir/"${oldfilenamexopp}".md 2>/dev/null
mv -f $inputDir/"${filenamexopp}".md $tempInputDir/"${filenamexopp}".md 2>/dev/null
mv -f "${filenamexopp}".md $inputDir/"${filenamexopp}".md

mv -f $inputDir/"${oldfilenamexopp}" $tempInputDir/"${oldfilenamexopp}" 2>/dev/null
mv -f $inputDir/"${filenamexopp}" $tempInputDir/"${filenamexopp}" 2>/dev/null
cp $templateDir/Notiz-Vorlage.xopp $inputDir/"$filenamexopp"

