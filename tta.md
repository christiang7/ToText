# tta
Created [Zettelkasten:2023:03:03]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **tta**   >  2277-11-11


Program for linking files to the assets folder


``noweb.py -Rtta.sh tta.md > tta.sh && echo 'fertig'``


``chmod u+x tta.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/GedankenspeicherCoding/tta.sh ~/.local/bin/tta.sh && echo 'fertig'``

```bash
{{tta.sh}}=
#!/usr/bin/env bash

wikipath=$(xclip -selection clipboard -o)

filepath=$(xclip -selection clipboard -o | sed "s,:,/,g" | sed "s, ,_,g")
filepath=$(echo ~/Gedankenspeicher/Gedankenspeicherwiki/$filepath)

destinationfolder=$(readlink -f -n "$1")
destinationfolder="${destinationfolder%.*}"

file=$(basename "$filepath")

mkdir -p $destinationfolder

ln -s "$filepath" "$destinationfolder"/"$file"
if [[ -e "$file".png ]] 
then
ln -s "$filepath".png "$destinationfolder"/"$file".png
fi
if [[ -e "$file".avif ]] 
then
ln -s "$filepath".avif "$destinationfolder"/"$file".avif
fi
ln -s "$filepath".txt "$destinationfolder"/"$file".txt



@

```

