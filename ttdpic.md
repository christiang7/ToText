# ttdpic

* ☑ **[../ttdpic](./ttdpic)**

Text creation time:
[Zettelkasten:2021:04:29]()
Modification time:
[Zettelkasten:2021:04:22]()

``  noweb.py -Rttdpic ttdpic.md > ttdpic && chmod u+x ttdpic && echo 'fertig'``

```bash
<<ttdpic>>=
#!/bin/bash
ls --hide=*.txt "$1" > f
while read f
do
  filetxt=$(echo "$f" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
  filename=$(basename "$f")
  touch "$1"/"$filetxt".txt
  echo "Content-Type: text/x-zim-wiki" >> "$1"/"$filetxt".txt
  echo "Wiki-Format: zim 0.6" >> "$1"/"$filetxt".txt
  echo "===== $filetxt =====" >> "$1"/"$filetxt".txt
  echo "[*] @BILD **[[../$filename]] $2**" >> "$1"/"$filetxt".txt
  echo "Text creation time:" >> "$1"/"$filetxt".txt
  date +"[[Zettelkasten:%Y:%m:%d]]" >> "$1"/"$filetxt".txt
  echo "Modification time:" >> "$1"/"$filetxt".txt
  date +"[[Zettelkasten:%Y:%m:%d]]" -r "$1"/"$filename" >> "$1"/"$filetxt".txt
  echo "{{../$filename?width=750}}" >> "$1"/"$filetxt".txt
  echo -e "\n$2\n" >> "$1"/"$filetxt".txt
done < f
rm f

@
```






