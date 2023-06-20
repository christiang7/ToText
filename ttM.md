# ttM

- [X] ttM

Umbenennung von Datei und der zugehörigen txt Datei, falls sich die original Datei ändert

- [X] **[../ttM](./ttM)**

Text creation time:
[Zettelkasten:2021:04:29]()
Modification time:
[Zettelkasten:2021:01:04]()

``noweb.py -RttM ttM.md > ttM && chmod u+x ttM && echo 'fertig'``

```bash
{{ttM}}=
#!/bin/bash
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
f=$(basename "$1")
touch "$File".md
echo "[ ] **[[../$f]]**" >> "$File".md
cat "$2" >> "$File".md
rm "$2"

@

```
