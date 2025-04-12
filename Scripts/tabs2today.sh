#! /bin/bash
source config.sh; # load the config library functions
journalDir="$(config_get journalDir)"
journalPage="$(config_get journalPage)"
source tt-lib.sh

additiontext=$1
if [ ! $? -eq 1 ];
then
  #text="$(xclip -selection clipboard -o)"
  text="$(wl-paste -n)"
  foldermonth=$(date +"$journalDir/%Y/%m")
  calendarfilename=$(date +"%d")
  calendarfile=${calendarfilename}.md
  if [[ ! -e "$foldermonth"/"$calendarfile" ]]
  then
	touch "$foldermonth"/"$calendarfile"
	Wikiprev "$(date +"%A %Y-%m-%d")"  >> "$foldermonth"/"$calendarfile"
	echo -e "$(date +"[[$journalPage:%Y:%m|%Y-%m]]")" >> "$foldermonth"/"$calendarfile"
  fi
  echo -e "\n${additiontext}\n${text}" >> "$foldermonth"/"$calendarfile"
  mkdir -p "$foldermonth"/"$calendarfilename"
  tabSessionName="2»websession_$(date +"%Y-%m-%d")"
  if [[ ! -e "$foldermonth"/"$calendarfilename"/"$tabSessionName".md ]]
  then
    echo -e "\n${additiontext}\n[[+$tabSessionName]]" >> "$foldermonth"/"$calendarfile"
    echo -e "===== $tabSessionName =====" >> "$foldermonth"/"$calendarfilename"/"$tabSessionName".md
  else
    echo -e "\n${additiontext}" >> "$foldermonth"/"$calendarfile"
  fi
  echo -e "${text}" >> "$foldermonth"/"$calendarfilename"/"$tabSessionName".md
fi
