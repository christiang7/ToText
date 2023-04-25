# tti
Created Dienstag [Zettelkasten:2022:10:11]()
Backlink [CodeFabrik]()

* ☑ **tti**  >  2277-11-11


  ``noweb.py -Rtti tti.md > tti && chmod u+x tti && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Gedankenwanderung/Programme/tti ~/.local/bin/tti && echo 'fertig'``

```bash
{{tti}}=
#!/bin/bash
File=$1

# in case of input is txt file
File2=$(basename "$1")
extens2=${File2##*.}
filename2=${File2%.*} #only the filename, here it is the original file

source=$(zenity --entry \
       --width 500 \
       --title "Noch eine Quelle hinzufügen?" \
       --text "Noch eine Quelle hinzufügen?" \
       --entry-text "$2")
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
if [[ $extens2 == md ]]
then
	File=$filename2
fi
if [[ $tags != "" ]]
then
sed -i "3 s/\*\*\[\[../$tags \*\*\[\[../" "$File".md
sed -i "4 s/\*\*\[\[../$tags \*\*\[\[../" "$File".md
fi
if [[ $source != "" ]]
then
sed -i "3 s/\]\]/\]\] $source/" "$File".md
sed -i "4 s/\]\]/\]\] $source/" "$File".md
fi
if [[ $additiontext != "" ]]
then
sed -i "s/\[\[..\/\]\]/\[\[..\/\]\]\n $additiontext/" "$File".md
fi
if zenity --question --text="Möchten Sie sich die Text nochmal anschauen?"
then 
kate "$File".md 2>/dev/null &
fi
#sed -i "9 i$additiontext" "$File"
@
```

