#!/bin/bash
htmlfolder="$1"
list=$(ls -1 "$htmlfolder")
echo $list
lines="$(wc --lines <<< "$list")"
cd $htmlfolder
for (( i=$lines ; i>=1 ; i-- ));
do
	element=$(sed -n "${i}p" <(echo "$list"))
	echo "$element"
    folder="$element"
    folder=$(echo $folder | sed 's/\///g')
    echo $folder
    #htmlFile=$(ls -1 "$folder" | grep "\.html ")
    htmlFile=$(find "$folder" -type f -iname "*.html")
    htmlFile=$(basename "$htmlFile")
    echo $htmlFile
    htmlFileName=$(basename "$htmlFile" .html)
    mv "$folder"/"$htmlFile" "$folder"/index.html
    touch "$folder"/index.dat "$folder"/index.rdf
    lynx -list_inline -dump "$folder"/index.html > "$folder"/index.rdf
    maffFileName=$(echo "$htmlFileName-$folder")
    ####mv "$folder" "$maffFileName"
    #zip -r $maffFileName.zip "$maffFileName"
    zip -r "$maffFileName".zip "$folder"
    mv "$maffFileName".zip "$maffFileName".maff
    #ttn $maffFileName.maff
    echo "Content-Type: text/x-zim-wiki" >> "$maffFileName".md
    echo "Wiki-Format: zim 0.6" >> "$maffFileName".md
    echo "====== $maffFileName.maff ======" >> "$maffFileName".md
    echo "Text date: $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]") File date: $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]" -r "$maffFileName".maff)" >> "$maffFileName".md
    folder2=$(unzip -Z -1 "$maffFileName.maff" '*/')
    echo "[*] **[[../$maffFileName.maff]]**" >> "$maffFileName".md
    cat $folder2'index.rdf' >> "$maffFileName".md
done
