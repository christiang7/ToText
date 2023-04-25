# ttam
Created [Zettelkasten:2023:03:06]()
Backlink [CodeFabrik:GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ **ttam**   >  2277-11-11

Program for moving files to the assets folder 



``noweb.py -Rttam.sh ttam.md > ttam.sh && echo 'fertig'``


``chmod u+x ttam.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/GedankenspeicherCoding/ttam.sh ~/.local/bin/ttam.sh && echo 'fertig'``

```bash
{{ttam.sh}}=
#!/usr/bin/env bash



folder=$(readlink -f -n "$1")
folder="${folder%/*}"

filename=$(ttrename "$1" 2> /dev/null)

#file=$(basename "$folder" .txt)


#filename=${file%.*}

assetsfolder=$(echo ~/Gedankenspeicher/Gedankenspeicherwiki/Assets)
wikipath=$(echo $assetsfolder | sed "s,/home/christian/Gedankenspeicher/Gedankenspeicherwiki/,," | sed "s,/,:,g")

mv "$folder"/"$filename" "$assetsfolder"/"$filename"
#mv "$folder"/"$file" "$assetsfolder"/"$file"

mv "$folder"/"${filename}"_files "$assetsfolder"/"${filename}"_files
mv "$folder"/"${filename}"-Dateien "$assetsfolder"/"${filename}"-Dateien
mv "$folder"/"${filename}"_Dateien "$assetsfolder"/"${filename}"_Dateien

mv "$folder"/"$filename".png "$assetsfolder"/"$filename".png
mv "$folder"/"$filename".avif "$assetsfolder"/"$filename".avif
mv "$folder"/"$filename".txt "$assetsfolder"/"$filename".txt

echo -e "[[$assetsfolder/$filename]]\n[[$wikipath:$filename]]" >> "$assetsfolder"/"$filename".txt
@

```

