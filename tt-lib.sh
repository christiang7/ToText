#!/bin/bash
source config.sh
journalPage="$(config_get journalPage)"

function cleanName () {
    echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g'|  sed 's/&/n/g' | sed 's/\///g' | sed 's/|//g' | sed 's/\[/(/g' | sed 's/\]/)/g' | sed 's/@/at/g' | sed 's/｜/-/g' | sed 's/：/;/g' | sed 's/？/ß/g'
}
function Wikiprev(){
    echo "Content-Type: text/x-zim-wiki" >> "$1"/"$2".md
    echo "Wiki-Format: zim 0.6" >> "$1"/"$2".md
    echo "====== $2 ======" >> "$1"/"$2".md
}

function WikiMarkprev(){
    echo "Content-Type: text/x-zim-wiki" >> "$1"/"$2".md
    echo "Wiki-Format: zim 0.6" >> "$1"/"$2".md
    echo "# $2 " >> "$1"/"$2".md
}

function Markdownprev(){
    echo "# $2 " >> "$1"/"$2".md
}

function Timestamps(){
    echo "Text date: $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]") Modi date: $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]" -r "$1"/"$2")" >> "$1"/"$2".md
}

function ttex(){
    folder=$1
    filename=$(basename "$folder"/"$2" .tex)
    f=$(basename "$3" .tex)
    foldertex="$filename"_tex
    mkdir -p "$foldertex" #
    mv "$f".pdf "$filename".pdf
    mv "$f".log "$filename".log
    mv "$f".aux "$filename".aux
    mv "$f".synctex.gz "$filename".synctex.gz
    mv "$f".toc "$filename".toc
    mv "$f".out "$filename".out
    mv "$f".blg "$filename".blg
    mv "$f".bbl "$filename".bbl
    mv "$f".run.xml "$filename".run.xml
    mv "$f".bcf "$filename".bcf
    mv "$f".sbl "$filename".sbl
    mv "$f".ist "$filename".ist
    mv "$filename".* "$folder"/"$foldertex"/ #
    #touch "$foldertex".md #
    WikiMarkprev "$folder" "$foldertex"
    #echo "Content-Type: text/x-zim-wiki" >> "$foldertex".md
    #echo "Wiki-Format: zim 0.6" >> "$foldertex".md
    #echo "# $filename" >> "$foldertex".md
    Timestamps "$folder" "$foldertex"
    #echo "Text date: $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]") Modi date: $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]" -r "$foldertex"/"$filename".tex)" >> "$foldertex".md
    echo "@LATEX $tags" >> "$folder"/"$foldertex".md
    #echo "- [X] **$folder **" >> "$foldertex".md #
    echo -e "[[./$filename.md]]\n[[./$filename.tex]]\n[[./$filename.pdf]]" >> "$folder"/"$foldertex".md
    #echo "Modification time: $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]" -r "$folder"/"$foldertex"/"$File")" >> "$folder".md
    echo -e "$source\n$additiontext" >> "$folder"/"$foldertex".md
    # latex file in markdown
    echo -e "# ${filename}.tex" >> "$folder"/"$foldertex"/"${filename}".md
    echo -e "Created [$(date +%Y-%m-%d)]()\n" >> "$folder"/"$foldertex"/"${filename}".md
    #echo -e "- [X] **${filename}.tex** " >> "$foldertex"/"${filename}".md
    echo -e " - [X] Doing" >> "$folder"/"$foldertex"/"${filename}".md
    echo -e " - [X] Backlog" >> "$folder"/"$foldertex"/"${filename}".md
    echo -e "    - [ ] " >> "$folder"/"$foldertex"/"${filename}".md
    echo -e "\n## Features" >> "$folder"/"$foldertex"/"${filename}".md
    echo -e "\n## Informations" >> "$folder"/"$foldertex"/"${filename}".md
    echo -e "\n## Latex File\n" >> "$folder"/"$foldertex"/"${filename}".md

    echo -e "\n*run-cell.sh*" >> "$folder"/"$foldertex"/"${filename}".md
    echo -e "\`\`\`bash" >> "$folder"/"$foldertex"/"${filename}".md
    echo -e "noweb.py -R${filename}.tex ${filename}.md > ${filename}.tex && pdflatex ${filename}.tex && xdg-open ${filename}.pdf 2>/dev/null \n\`\`\`\n\n" >> "$folder"/"$foldertex"/"${filename}".md
    echo -e "*${filename}.tex*" >> "$folder"/"$foldertex"/"${filename}".md
    echo -e "\`\`\`tex" >> "$folder"/"$foldertex"/"${filename}".md
    cat "$folder"/"$foldertex"/"${filename}".tex >> "$folder"/"$foldertex"/"${filename}".md
    # echo -e "\n@" >> "$foldertex"/"${filename}".md
    echo -e "\n\`\`\`" >> "$folder"/"$foldertex"/"${filename}".md

    #ln -s "$folder"/"$folder"/"$File" "$folder"/"$File"
    #ln -s "$folder"/"$filename".pdf "$filename".pdf
    #kate "$folder".md 2>/dev/null &
}


