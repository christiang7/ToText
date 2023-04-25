# ttvid

* ☑ **ttvid**  

Created Sonntag [Zettelkasten:2021:05:23]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

Das Script kann die Videodatei in eine Zim Textdatei einfügen und von dort aus anklickbar abspielbar machen

  ``noweb.py -Rttvid ttvid.txt > ttvid && chmod u+x ttvid && echo 'fertig``'

```awk
<<ttvid>>=
#!/bin/bash
Zimtxt=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d.txt" -r "$1")
file=$(basename "$1")
pathfile=$(realpath "$1" --relative-to=/home/christian)
pathfiletxt=$(echo "$pathfile" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g' )
touch "$Zimtxt"
echo -e "\n" >> "$Zimtxt"
echo [ ] ">2277-11-11" @VIDEO @VIDEOARCHIV "$2" "$file" [[~/"$pathfiletxt".txt]] ";" [[~/"$pathfile"]] >> "$Zimtxt"
echo -e "\nIST IM WIKI!!!" >> ~/"$pathfiletxt".txt
@ 

```

