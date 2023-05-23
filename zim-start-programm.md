# zim-start-programm
Created Dienstag [Zettelkasten:2022:10:11]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **zim-start-programm**  >  2277-11-11


  ``noweb.py -Rzim-start-programm.sh zim-start-programm.md > zim-start-programm.sh && echo 'fertig'``


``chmod u+x zim-start-programm.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Gedankenwanderung/Programme/zim-start-programm.sh ~/.local/bin/zim-start-programm.sh && echo 'fertig'``

```bash
{{zim-start-programm.sh}}=
  #!/bin/bash
  if zenity --question --text="Möchten Sie dieses Programm: $1 : öffnen?"
  then
    konsole -e "$1"
  fi
```

