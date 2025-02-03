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
    echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g'|  sed 's/&/n/g' | sed 's/\///g' | sed 's/|//g' | sed 's/\[/(/g' | sed 's/\]/)/g' | sed 's/@/at/g' | sed 's/：/;/g' | sed 's/？/ß/g' | sed "s/|/;/g" | sed "s/·/;/g" | sed "s/💤/;/g" | sed 's/｜/-/g'
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

#*Markdown-file-description}}

#*ttvid}}


```

### file description

using ``file-description`` function with the parameters as following
```bash
    file-description p1 p2 p3 p4 p5 p6 p7
    p1 - folder
    p2 - cleaned filename
    p3 - tags
    p4 - source
    p5 - additiontext
    p6 - picture
    p7 - folder switch
```

*file-description*
```bash
function file-description(){
    folder=$1
    File=$2
    tags=$3
    source=$4
    additiontext=$5
    picture=$6
    folderSwitch=$7
    if [[ ! $folderSwitch == "" ]]
    then
        extens=${File##*.}
        Filename=${File%.*}
        filefolder=$Filename
        mkdir -p $folder/"$filefolder"
        mv $folder/"$File" $folder/"$filefolder"/"$File"
        mv $folder/"$filefolder" $folder/"$File"
        filefolder="$filefolder.$extens"
    fi
    Wikiprev "$folder" "$File"
    Timestamps "$folder" "$File"
    echo "$tags" >> "$folder"/"$File".md
    echo "**[[./$File]]**" >> "$folder"/"$File".md
    if [[ ! $picture == "" ]]
    then
        if [[ ! $folderSwitch == "" ]]
        then
            echo "{{./$File.avif?width=500}}" >> "$folder"/"$File".md
        else
            echo "{{../$File.avif?width=500}}" >> "$folder"/"$File".md
        fi
    fi
    echo -e "$source\n$additiontext\n" >> "$folder"/"$File".md
}
```

### Markdown file description

using ``Markdown-file-description`` function with the parameters as following
```bash
    Markdown-file-description p1 p2 p3 p4 p5
    p1 - folder
    p2 - cleaned filename
    p3 - tags
    p4 - source
    p5 - additiontext
```

*Markdown-file-description*
```bash
function Markdown-file-description(){
    Markdownprev "$1" "$2"
    echo "Text creation time: [%Y-%m-%d]($(date +"$journalPage/%Y/%m/%d")) Modification time: [%Y-%m-%d]($(date +"$journalPage/%Y/%m/%d" -r "$File"))" >> "$1"/"$2".md
    echo "$3" >> "$1"/"$2".md
    echo "**["$2"]] **" >> "$1"/"$2".md
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
    p2 - picture - file
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

### ttvid

using ``ttvid`` function with the parameters as following
```bash
    ttviddown p1 p2 p3 p4 p5 p6 p7 p8
    p1 - folder
    p2 - video - file
    p3 - tags
    p4 - source
    p5 - additiontext
    p6 - video not cleaned filename
    p7 - folder switch
    p8 - Download switch
```

*ttvid*
```bash
function ttvid(){
    folder=$1
    File=$2
    tags=$3
    source=$4
    additiontext=$5
    ofile=$6
    folderSwitch=$7
    downloadSwitch=$8
    name=${File%.*}
    extens=${File##*.}
    oname=${ofile%.*}
    if [[ ! $folderSwitch == "" ]]
    then
        fileFolder=$folder/$File
    else
        fileFolder=$folder
    fi
    if [[ ! $downloadSwitch == "" ]]
    then
        additiontext="$(yt-dlp --get-description ${source})"
        file-description "$folder" "$File" "@VIDEO $tags" "$source" "$additiontext" "pic" "$folderSwitch"
        yt-dlp -q --sub-langs "en,de" --write-sub --write-thumbnail --write-auto-sub --sub-format "vtt" --skip-download -i ${source} -o "$folder/%(title)s.%(ext)s"
        mv "$folder/$oname".en.vtt "$filefolder"/"$name".en.vtt
        mv "$folder/$oname".de.vtt "$filefolder"/"$name".de.vtt
        convert "$folder/$oname.webp" "$filefolder"/"$File".avif
        rm "$folder/$oname.webp"
        subtitlefile1="$name".en.vtt
        subtitlefile2="$name".de.vtt
    else
		file-description "$folder" "$File" "@VIDEO $tags" "$source" "$additiontext" "pic" "$folderSwitch"
		# cat the old text file to the new one, then we do not need the vidc script
		cat ${oname}.txt >> "$folder"/"$File".md
		rm ${oname}.txt
		ffmpeg -loglevel quiet -ss 2 -i "$filefolder"/"$File"  -t 1 -f image2 "$folder"/"$File".png
        convert "$folder"/"$File".png -resize 1200x1200 "$filefolder"/"$File".avif
		rm "$folder"/"$File".png
        ffmpeg -i "$folder"/"${oname}.srt" "$filefolder"/"${name}.vtt"
        mv "$folder"/"${oname}.ttml" "$filefolder"/"${name}.ttml"
        rm "$folder"/"${name}.srt"
        subtitlefile1=${name}.vtt
        subtitlefile2=${name}.ttml
    fi

	echo -e "\n*$subtitlefile1*" >> "$folder"/"$File".md
	echo -e "\`\`\`bash" >> "$folder"/"$File".md
	cat "$filefolder"/"$subtitlefile1" >> "$folder"/"$File".md
	echo -e "\`\`\`" >> "$folder"/"$File".md
	echo -e "\n*$subtitlefile2*" >> "$folder"/"$File".md
	echo -e "\`\`\`bash" >> "$folder"/"$File".md
	cat "$filefolder"/"$subtitlefile2" >> "$folder"/"$File".md
	echo -e "\`\`\`" >> "$folder"/"$File".md
	echo -e "\n*run-cell.sh*" >> "$folder"/"$File".md
	echo -e "\`\`\`bash" >> "$folder"/"$File".md
	echo -e "noweb.py -R$subtitlefile1 $File.md > $subtitlefile1 \nnoweb.py -R$subtitlefile2 $File.md > $subtitlefile2 \n echo '$File' && date \n\`\`\`\n\n" >> "$folder"/"$File".md
}
```

### ttpdf

using ``ttpdf`` function with the parameters as following
```bash
    ttpdf p1 p2 p3 p4 p5
    p1 - folder
    p2 - file - picture
    p3 - tags
    p4 - source
    p5 - additiontext
```

*ttpdf*
```bash
function ttpdf(){
    File=$(cleanName "$2")
    file-description "$1" "$File" "@Document $3" "$4" "$5" "pic" "yes"

    folder=$(basename "$File" .pdf)

    pdftoppm -png -singlefile "$folder"/"$File" "$folder"/"$File"
    convert "$folder"/"$File".png -resize 800x800 "$folder"/"$File".avif
    rm "$folder"/"$File".png
    pdfinfo "$folder"/"$File" | grep Pages >> "$File".md
    echo -e "\n" >> "$File".md
    pdftotext -nopgbrk -enc UTF-8 -f 1 -l 1 "$folder"/"$File" ->> "$File".md

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
