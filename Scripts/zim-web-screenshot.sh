#! /bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"
journalDir="$(config_get journalDir)"
source tt-lib.sh

yad --title="Take screenshot?" --text="\n Taking screenshot\n"
if [ ! $? -eq 1 ];
then
    url="$1"
    selecttext="$2"
    #urltitle=$(wget -qO- "$url" | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)\s*<\/title/si' | recode html..)
    urltitle=$(xidel -s "$url" --css title | tr -d '\n')
    folder=$(date +"$journalDir/%Y/%m/%d")
    mkdir -p $folder
    filename=$(echo "Web-Screenshot-$urltitle" | sed 's/ /_/g' | sed 's/\//_/g' | sed 's/?/__/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g' | sed 's/\&/n/g' | sed -e "s/|//g" | sed 's/\[/(/g' | sed 's/\]/)/g')
    File="$filename".png
    scrot "$folder"/"$File" -s
    foldermonth=$(date +"$journalDir/%Y/%m")
    calendarfile=$(date +"%d")
    calendarfile=$calendarfile.md
    if [[ ! -e "$foldermonth"/"$calendarfile" ]]
    then
        touch "$foldermonth"/"$calendarfile"
        echo "Content-Type: text/x-zim-wiki" >> "$foldermonth"/"$calendarfile"
        echo "Wiki-Format: zim 0.6" >> "$foldermonth"/"$calendarfile"
        date +"===== %A %d %b %Y =====" >> "$foldermonth"/"$calendarfile"
        #date +"[[$journalPage:%Y:Week %W|Week %W]]" >> "$foldermonth"/"$calendarfile"
        date +"[[$journalPage:%Y:%m]]" >> "$foldermonth"/"$calendarfile"
        echo -e ""  >> "$foldermonth"/"$calendarfile"
        date +"[*] ** %A %d %b %Y ** " >> "$foldermonth"/"$calendarfile"
    fi
    abfrage=$(yad --title="Add meta data" --text="Something to add?" \
		--form --width 500 --separator="~" --item-separator=","  \
		--field="Tags" \
		--field="Something more":TXT \
		"$tags" "$additiontext")
		tags=$(echo $abfrage | cut -s -d "~" -f 1)
		additiontext=$(echo $abfrage | cut -s -d "~" -f 2)
    touch "$File".md
    mv "$File".md "$folder"/"$File".md
    echo "Content-Type: text/x-zim-wiki" >> "$folder"/"$File".md
    echo "Wiki-Format: zim 0.6" >> "$folder"/"$File".md
    echo "===== $File =====" >> "$folder"/"$File".md
    echo "[*] @BILD @Webseite @Screenshot $tags **[[../$File]] $url**" >> "$folder"/"$File".md
    echo "Text creation time: $(date +"[[$journalPage:%Y:%m:%d]]")" >> "$folder"/"$File".md
    echo "Modification time: $(date +"[[$journalPage:%Y:%m:%d]]" -r "$folder"/"$File")" >> "$folder"/"$File".md
    echo -e "\n" >> "$folder"/"$File".md
    echo "{{../$File}}" >> "$folder"/"$File".md
    echo "$additiontext" >> "$folder"/"$File".md
    tesseract -l eng+deu "$folder"/"$File" stdout | sed 's/\o14//g' >> "$folder"/"$File".md
    echo -e "\n[*] $urltitle" >> "$foldermonth"/"$calendarfile"
    if [[ ! $additiontext == "" ]]
    then
        echo -e "$additiontext" >> "$foldermonth"/"$calendarfile"
    fi
    echo -e "$url" >> "$foldermonth"/"$calendarfile"
    echo -e "[[+$File]]" >> "$foldermonth"/"$calendarfile"
    echo -e "{{$File}}" >> "$foldermonth"/"$calendarfile"
fi
