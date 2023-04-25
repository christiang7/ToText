# ttdel
Created Dienstag [Zettelkasten:2022:06:14]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **ttdel**  >  2277-11-11
	* ☑ PLUS noch Verzeichnisse löschbar machen


  ``noweb.py -Rttdel ttdel.md > ttdel && echo 'fertig'``

 ``chmod u+x ttdel && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Gedankenwanderung/Programme/ttdel ~/.local/bin/ttdel && echo 'fertig'``

```bash
{{ttdel}}=
#!/bin/bash
if zenity --question --text="Wirklich löschen?"
then 
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')

File2=$(basename "$1")
extens2=${File2##*.}
filename2=${File2%.*} #only the filename, here the filename of the original file

if [[ $extens2 == txt ]]
then
	rm -r "$filename2"
	rm "$filename2".avif
	rm "$filename2".png
	rm "$filename2".pdf
	rm "$filename2".pdf.png
	rm "$filename2".pdf.avif
	rm "$1"
else 
	rm -r "$1"
	rm "$File".txt
	rm "$File".avif
	rm "$File".png
	rm "$File".pdf
	rm "$File".pdf.avif
	rm "$File".pdf.png
fi

fi

@
```

