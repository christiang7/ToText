# ttviddown

* ☑ **ttviddown**  

Angelegt Donnerstag [Zettelkasten:2021:05:27]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

 ``youtube-dl --exec "ttdown {} [HREF] '[SELECTIONTEXT]' " [HREF]`` 

  ``noweb.py -Rttviddown ttviddown.md > ttviddown && chmod u+x ttviddown && echo 'fertig'``

```bash
<<ttviddown>>=
#!/bin/bash
File=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d.txt" -r "$1")
f=$(basename "$1")
touch "$File"
echo -e "\n" >> "$File"
echo "Content-Type: text/x-zim-wiki" >> "$File".txt
echo "Wiki-Format: zim 0.6" >> "$File".txt
echo "===== $File =====" >> "$File".txt
echo [ ] @VIDEO @VIDEOARCHIV "$2" "$f" >> "$File"
@ 

```


