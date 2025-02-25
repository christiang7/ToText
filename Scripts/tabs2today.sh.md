# tabs2today
Created Dienstag [Zettelkasten:2022:10:25]()

- [x] **tabs2today**
	- [x] Doing
	- [x] Backlog


*run-cell.sh*
```bash
noweb.py -Rtabs2today.sh tabs2today.sh.md > tabs2today.sh && echo 'fertig'
```


*tabs2today.sh*
```bash
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
	#*note template}}
  fi
  echo -e "\n${additiontext}\n${text}" >> "$foldermonth"/"$calendarfile"
  #*tabsession to today}}
fi
```
### tabsession to today

*tabsession to today*
```bash
mkdir -p "$foldermonth"/"$calendarfilename"
tabSessionName="2»websession_$(date +"%Y-%m-%d")"
if [[ ! -e "$foldermonth"/"$calendarfilename"/"$tabSessionName".md ]] 
then
  echo -e "\n${additiontext}\n[[+$tabSessionName]]" >> "$foldermonth"/"$calendarfile"
else
  echo -e "\n${additiontext}" >> "$foldermonth"/"$calendarfile"
fi 
echo -e "${text}" >> "$foldermonth"/"$calendarfilename"/"$tabSessionName".md
```


### note template

*note template*
```bash
Wikiprev "$(date +"%A %Y-%m-%d")"  >> "$foldermonth"/"$calendarfile"
echo -e "$(date +"[[$journalPage:%Y:%m|%Y-%m]]")" >> "$foldermonth"/"$calendarfile"
```
