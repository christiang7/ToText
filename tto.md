# tto

* ☑ tto

Das gleiche wie das Skript tt, nur wird hier nur die Datei erzeugt nicht mehr.

* ☑ **[../tto](./tto)**

Text creation time:
[Zettelkasten:2021:04:29]()
Modification time:
[Zettelkasten:2021:04:16]()

``  noweb.py -Rtto tto.md > tto && chmod u+x tto && echo 'fertig'``

```bash
<<tto>>=
#!/bin/bash
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
f=$(basename "$1")
touch "$File".txt
echo "Content-Type: text/x-zim-wiki" >> "$File".txt
echo "Wiki-Format: zim 0.6" >> "$File".txt
echo "[*] **[[../$f]] $2**" >> "$File".txt
echo "$2" >> "$File".txt
echo "$3" >> "$File".txt
@
```

