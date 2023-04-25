# firefox-open-zim
Created Montag [Zettelkasten:2022:12:19]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ @Firefox @Zim @Wiki  **firefox-open-zim**  >  2277-11-11



``echo http://localhost:8080/Zettelkasten/Gedankenwanderung/Zim-Arbeitsflaeche.html | sed "s,http://localhost:8080/,," | sed "s,.html,,"  | sed "s,/,:,g"``

``noweb.py -Rfirefox-open-zim.sh firefox-open-zim.md > firefox-open-zim.sh && echo 'fertig'``

``chmod u+x firefox-open-zim.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/Gedankenwanderung/Programme/firefox-open-zim.sh ~/.local/bin/firefox-open-zim.sh && echo 'fertig'``

```bash
{{firefox-open-zim.sh}}=
url=$(echo "$1" | sed "s,http://localhost:8080/,," | sed "s,.html,,"  | sed "s,/,:,g")
cd ~
./Programme/zim/zim.py --gui --fullscreen Gedankenspeicherwiki "$url" 
@

```

