# zim-dir-txt
Created Mittwoch [Zettelkasten:2022:06:15]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **zim-dir-txt**  >  2277-11-11
	* ☑ dabei auch schauen, dass die neuen Dateinamen auch in die txt Datei eingetragen werden durch die Korrektur von ttn


  ``noweb.py -Rzim-dir-txt.sh zim-dir-txt.md > zim-dir-txt.sh && chmod u+x zim-dir-txt.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Gedankenwanderung/Programme/zim-dir-txt.sh ~/.local/bin/zim-dir-txt.sh && echo 'fertig'``


```bash
{{zim-dir-txt.sh}}=
  #! /bin/bash
  if zenity --question --text="Möchten Sie dieses Programm: ttd ausführen?"
  then 
    File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
    filename=${File%.*}
    mkdir -p "$filename"
    ttd "$filename"
  fi
@
```

