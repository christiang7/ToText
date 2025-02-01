# tt-lib.sh
Created [2025-02-01](2025-02-01)

- [X] **tt-lib.sh**
    - [X] Doing
    - [X] Backlog

## Features



## Informations
 Christian Gößl
## Main Program


*run-cell.sh*
```bash
noweb.py -Rtt-lib.sh tt-lib.sh.md > tt-lib.sh && echo 'tt-lib.sh' && date 
```


```bash
chmod u+x tt-lib.sh && ln -sf $(pwd)/tt-lib.sh ~/.local/bin/tt-lib.sh && echo 'fertig'
```

*tt-lib.sh*
```bash
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

#*ttex}}

#*file-description}}

#*ttpic}}

#*create-note}}

```

### file description

using ``file-description`` function with the parameters as following
```bash
    file-description p1 p2 p3 p4 p5
    p1 - folder
    p2 - cleaned filename
    p3 - tags
    p4 - source
    p5 - additiontext
```

*file-description*
```bash
function file-description(){
    Wikiprev "$1" "$2"
    Timestamps "$1" "$2"
    echo "$3" >> "$1"/"$2".md
    echo "**[[../$2]]**" >> "$1"/"$2".md
    echo -e "$4\n$5\n" >> "$1"/"$2".md
}
```


### create note

using ``create-note`` function with the parameters as following
```bash
    create-note p1 p2 p3 p4 p5
    p1 - folder
    p2 - title
    p3 - tags
    p4 - source
    p5 - additiontext
```

*create-note*
```bash
function create-note(){
    folder=$1
    title=$2
    File=$(cleanName "$title")
    mkdir -p "${folder}"/"${File}"
    echo "Content-Type: text/x-zim-wiki" > "${folder}"/"${File}".md
    echo "Wiki-Format: zim 0.6" >> "${folder}"/"${File}".md
    echo -e "====== ${title} ======" >> "${folder}"/"${File}".md
    echo -e "$3" >> "${folder}"/"${File}".md
    echo -e "$4\n$5\n" >> "${folder}"/"${File}".md
    echo -e "==== Journal ====\n" >> "${folder}"/"${File}".md
    echo -e "=== $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]") ===" >> "${folder}"/"${File}".md
}
```


### ttpic

using ``ttpic`` function with the parameters as following
```bash
    ttpic p1 p2 p3 p4 p5
    p1 - folder
    p2 - file - picture
    p3 - tags
    p4 - source
    p5 - additiontext
```

*ttpic*
```bash
function ttpic(){
    File=$(cleanName "$2")
    file-description "$1" "$File" "@BILD $3" "$4" "$5"
    echo "{{../$File?width=500}}" >> "$1"/"$File".md
}
```



### ttex

using ``ttex`` function with the parameters as following
```bash
    ttex p1 p2 p3
    p1 - folder
    p2 - cleaned filename
    p3 - original file
```

*ttex*
```bash
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
    Timestamps "$folder" "$foldertex"
    echo "@LATEX $tags" >> "$folder"/"$foldertex".md
    echo -e "[[./$filename.md]]\n[[./$filename.tex]]\n[[./$filename.pdf]]" >> "$folder"/"$foldertex".md
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

```
