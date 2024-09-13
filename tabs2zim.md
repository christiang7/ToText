# tabs2zim
Created Dienstag [Zettelkasten:2022:10:25]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **tabs2zim**
	- [X] Doing
	- [X] Backlog


```bash
{{run-cell.sh}}=
noweb.py -Rtabs2zim.sh tabs2zim.md > tabs2zim.sh && echo 'fertig'
@
```

```bash
 chmod u+x tabs2zim.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/GedankenspeicherCoding/tabs2zim.sh ~/.local/bin/tabs2zim.sh && echo 'fertig'
```

```bash
{{tabs2zim.sh}}=
#! /bin/bash
#if zenity --question --text="Möchten Sie die Links in Firefox öffnen?"
#then 

additiontext=$(echo $1)
if [ ! $? -eq 1 ]; 
then
  #text="$(xclip -selection clipboard -o)"
  text="$(wl-paste -n)"
  foldermonth=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m")
  calendarfile=$(date +"%d")
  calendarfile=${calendarfile}.md
  if [[ ! -e "$foldermonth"/"$calendarfile" ]] 
  then
	touch "$foldermonth"/"$calendarfile"
	{{zim template}}
  fi
  echo -e "\n${additiontext}\n${text}" >> "$foldermonth"/"$calendarfile"

fi
@
```


#### zim template
```bash
{{zim template}}=
echo "Content-Type: text/x-zim-wiki" >> "$foldermonth"/"$calendarfile"
echo "Wiki-Format: zim 0.6" >> "$foldermonth"/"$calendarfile"
#date +"====== %A %d %b %Y ======" >> "$foldermonth"/"$calendarfile"
echo -e "====== $(date +"%A %Y-%m-%d") ======" >> "$foldermonth"/"$calendarfile"
#date +"[[Zettelkasten:%Y:Week %W|Week %W]]">> "$foldermonth"/"$calendarfile"
#date +"[[Zettelkasten:%Y:%m]]" >> "$foldermonth"/"$calendarfile"
#echo -e ""  >> "$foldermonth"/"$calendarfile"
#date +"[*] ** %A %d %b %Y ** " >> "$foldermonth"/"$calendarfile"
echo -e "$(date +"[*] ** %A %Y-%m-%d **")  $(date +"[[Zettelkasten:%Y:%m|%Y-%m]]")" >> "$foldermonth"/"$calendarfile"
@
```


#### markdown template
```bash
{{markdown template}}=
echo -e "# $(date +"%A %Y-%m-%d")" >> "$foldermonth"/"$calendarfile"
echo -e "$(date +"- [X] ** %A %Y-%m-%d **")  $(date +"[[Zettelkasten/%Y/%m|%Y-%m]]")" >> "$foldermonth"/"$calendarfile"
@
```