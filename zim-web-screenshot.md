# zim-web-screenshot
Created Freitag [Zettelkasten:2022:10:07]()
Backlink [CodeFabrik:GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **zim-web-screenshot**  >  2277-11-11


[Zettelkasten:2022:05:01:Screenshots in Firefox offener tabs]()

<https://unix.stackexchange.com/questions/103252/how-do-i-get-a-websites-title-using-command-line> | web - How do I get a websites title using command line? - Unix & Linux Stack Exchange
<https://github.com/benibela/xidel> | Releases · benibela/xidel
<https://unix.stackexchange.com/questions/382077/replace-a-string-including-a-slash-using-sed-command> | text processing - Replace a string including a slash "/" using sed command - Unix & Linux Stack Exchange
<https://wiki.ubuntuusers.de/tesseract-ocr/> | tesseract-ocr › Wiki › ubuntuusers.de
<https://ostechnix.com/take-screenshots-command-line-using-scrot-linux/> | How To Take Screenshots From Command Line Using "Scrot" In Linux

``tesseract -l eng 2209.14792.pdf.png stdout``

  ``noweb.py -Rzim-web-screenshot.sh zim-web-screenshot.md > zim-web-screenshot.sh && echo 'fertig'``


``chmod u+x zim-web-screenshot.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/ZetteL/CodeFabrik/GedankenspeicherCoding/zim-web-screenshot.sh ~/.local/bin/zim-web-screenshot.sh && echo 'fertig'``

```bash
{{zim-web-screenshot.sh}}=
  #! /bin/bash
  if zenity --question --text="Möchten Sie dieses Programm ein Screenshot aufnehmen?"
  then 
    url="$1"
    selecttext="$2"
    #urltitle=$(wget -qO- "$url" | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)\s*<\/title/si' | recode html..)
    urltitle=$(xidel -s "$url" --css title | tr -d '\n')
    folder=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d")
    mkdir -p $folder
    filename=$(echo "Web-Screenshot-$urltitle" | sed 's/ /_/g' | sed 's/\//_/g' | sed 's/?/__/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g' | sed 's/\&/n/g' | sed -e "s/|//g" | sed 's/\[/(/g' | sed 's/\]/)/g')
    File="$filename".png
    scrot "$folder"/"$File" -s
    foldermonth=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m")
    calendarfile=$(date +"%d")
    calendarfile=$calendarfile.md
    if [[ ! -e "$foldermonth"/"$calendarfile" ]] 
    then
        touch "$foldermonth"/"$calendarfile"
        echo "Content-Type: text/x-zim-wiki" >> "$foldermonth"/"$calendarfile"
        echo "Wiki-Format: zim 0.6" >> "$foldermonth"/"$calendarfile"
        date +"===== %A %d %b %Y =====" >> "$foldermonth"/"$calendarfile"
        date +"[[:Zettelkasten:%Y:Week %W|Week %W]]" >> "$foldermonth"/"$calendarfile"
        date +"[[Zettelkasten:%Y:%m]]" >> "$foldermonth"/"$calendarfile"
        echo -e "[[../]]"  >> "$foldermonth"/"$calendarfile"
        date +"[*] ** %A %d %b %Y ** >  2277-11-11" >> "$foldermonth"/"$calendarfile"
    fi
    tags=$(zenity --entry \
          --width 500 \
          --title "Noch Schlagwörter hinzufügen?" \
          --text "Noch Schlagwörter hinzufügen?" \
          --entry-text "$3")
    additiontext=$(zenity --entry \
          --width 500 \
          --title "Noch etwas hinzufügen?" \
          --text "Noch etwas hinzufügen?" \
          --entry-text "$4")
    touch "$File".md
    mv "$File".md "$folder"/"$File".md
    echo "Content-Type: text/x-zim-wiki" >> "$folder"/"$File".md
    echo "Wiki-Format: zim 0.6" >> "$folder"/"$File".md
    echo "===== $File =====" >> "$folder"/"$File".md
    echo "[*] @BILD @Webseite @Screenshot $tags **[[../$File]] $url**" >> "$folder"/"$File".md
    echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" >> "$folder"/"$File".md
    echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$folder"/"$File")" >> "$folder"/"$File".md
    echo -e "[[../]]\n" >> "$folder"/"$File".md
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
@
```

