# zim-dir-txt
Created Mittwoch [2022-06-15]()
- [X] **zim-dir-txt**


  ```bash
noweb.py -Rzim-dir-txt.sh zim-dir-txt.md > zim-dir-txt.sh && echo 'fertig'
 ```
   ```bash
chmod u+x zim-dir-txt.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Gedankenwanderung/Programme/zim-dir-txt.sh ~/.local/bin/zim-dir-txt.sh && echo 'fertig'
```

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

