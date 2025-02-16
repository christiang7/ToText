#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
inputDir="$(config_get inputDir)"
tempInputDir="$(config_get tempInputDir)"
templateDir="$(config_get templateDir)"
source tt-lib.sh

file-description "$(pwd)" "$(date +"Draft_%Y-%m-%d".xopp)" "" "" "" >> "$(pwd)"/"$(date +"Draft_%Y-%m-%d".xopp)".md

#create-note "$(pwd)" "$(date +"Draft page %Y-%m-%d")" "" "" ""

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

