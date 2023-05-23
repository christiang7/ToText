# ttvid2

* ☑ **ttvid2**  

Created Montag [Zettelkasten:2021:10:18]()
Backlink [CodeArbeitsflaeche]()

Das Script kann die Videodatei in eine Zim Textdatei einfügen und von dort aus anklickbar abspielbar machen

  ``noweb.py -Rttvid2 ttvid2.md > ttvid2 && chmod u+x ttvid2 && echo 'fertig'``

```bash
{{ttvid2}}=
  #!/bin/bash
  Zimtxt=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d.md" -r "$1")
  file=$(basename "$1")
  filetxt=$(basename "$1" | sed 's/\(.*\)\..*/\1/')
  pathfile=$(realpath "$1" --relative-to=/home/christian)
  pathfiletxt=$(realpath "$filetxt".md --relative-to=/home/christian)
  touch "$Zimtxt"
  echo -e "\n" >> "$Zimtxt"
  echo [ ] ">2277-11-11" @VIDEO @VIDEOARCHIV "$2" "$file" [[~/"$pathfiletxt"]] ";" [[~/"$pathfile"]] >> "$Zimtxt"
  echo -e "\nIST IM WIKI!!!" >> ~/"$pathfiletxt".md
@ 

```

