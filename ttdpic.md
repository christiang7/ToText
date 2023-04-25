# ttdpic

* ☑ **[../ttdpic](./ttdpic)**

Text creation time:
[Zettelkasten:2021:04:29]()
Modification time:
[Zettelkasten:2021:04:22]()

``  noweb.py -Rttdpic ttdpic.md > ttdpic && chmod u+x ttdpic && echo 'fertig'``

```bash
{{ttdpic}}=
#!/bin/bash
ls --hide=*.md "$1" > f
while read f
do
  filetxt=$(echo "$f" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
  filename=$(basename "$f")
  touch "$1"/"$filetxt".md
  echo "Content-Type: text/x-zim-wiki" >> "$1"/"$filetxt".md
  echo "Wiki-Format: zim 0.6" >> "$1"/"$filetxt".md
  echo "===== $filetxt =====" >> "$1"/"$filetxt".md
  echo "[*] @BILD **[[../$filename]] $2**" >> "$1"/"$filetxt".md
  echo "Text creation time:" >> "$1"/"$filetxt".md
  date +"[[Zettelkasten:%Y:%m:%d]]" >> "$1"/"$filetxt".md
  echo "Modification time:" >> "$1"/"$filetxt".md
  date +"[[Zettelkasten:%Y:%m:%d]]" -r "$1"/"$filename" >> "$1"/"$filetxt".md
  echo "{{../$filename?width=750}}" >> "$1"/"$filetxt".md
  echo -e "\n$2\n" >> "$1"/"$filetxt".md
done < f
rm f

@
```






