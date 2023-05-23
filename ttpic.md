# ttpic

* ☑ **[../ttpic](./ttpic)**

Text creation time:
[Zettelkasten:2021:04:29]()
Modification time:
[Zettelkasten:2021:04:22]()

  ``noweb.py -Rttpic ttpic.md > ttpic && chmod u+x ttpic && echo 'fertig'``

```bash
{{ttpic}}=
  #!/bin/bash
  File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
  f=$(basename "$1")
  touch "$File".md
  echo "Content-Type: text/x-zim-wiki" >> "$File".md
  echo "Wiki-Format: zim 0.6" >> "$File".md
  echo "===== $f =====" >> "$File".md
  echo "[*] @BILD $3 **[[../$f]] $2**" >> "$File".md
  echo "Text creation time: $(date +"[[Zettelkasten:%Y:%m:%d]]")" >> "$File".md
  echo "Modification time: $(date +"[[Zettelkasten:%Y:%m:%d]]" -r "$1")" >> "$File".md
  echo -e "[[../]]\n" >> "$File".md
  echo "{{../$f?width=750}}" >> "$File".md
  echo -e "\n$4" >> "$File".md
  #kate "$File".md 2>/dev/null & 
  #sleep 10
  #kwrite
  #echo fertig
@
```



