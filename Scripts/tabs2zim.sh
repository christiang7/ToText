#! /bin/bash
source config.sh; # load the config library functions
journalDir="$(config_get journalDir)"
journalPage="$(config_get journalPage)"

additiontext=$(echo $1)
if [ ! $? -eq 1 ];
then
  #text="$(xclip -selection clipboard -o)"
  text="$(wl-paste -n)"
  foldermonth=$(date +"$journalDir/%Y/%m")
  calendarfile=$(date +"%d")
  calendarfile=${calendarfile}.md
  if [[ ! -e "$foldermonth"/"$calendarfile" ]]
  then
	touch "$foldermonth"/"$calendarfile"
	echo "Content-Type: text/x-zim-wiki" >> "$foldermonth"/"$calendarfile"
	echo "Wiki-Format: zim 0.6" >> "$foldermonth"/"$calendarfile"
	#date +"====== %A %d %b %Y ======" >> "$foldermonth"/"$calendarfile"
	echo -e "====== $(date +"%A %Y-%m-%d") ======" >> "$foldermonth"/"$calendarfile"
	#date +"[[$journalPage:%Y:Week %W|Week %W]]">> "$foldermonth"/"$calendarfile"
	#date +"[[$journalPage:%Y:%m]]" >> "$foldermonth"/"$calendarfile"
	#echo -e ""  >> "$foldermonth"/"$calendarfile"
	#date +"[*] ** %A %d %b %Y ** " >> "$foldermonth"/"$calendarfile"
	echo -e "$(date +"[[$journalPage:%Y:%m|%Y-%m]]")" >> "$foldermonth"/"$calendarfile"
  fi
  echo -e "\n${additiontext}\n${text}" >> "$foldermonth"/"$calendarfile"

fi
