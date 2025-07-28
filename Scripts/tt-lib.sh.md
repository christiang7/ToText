# tt-lib.sh
Created [2025-02-01](2025-02-01)

- [x] **tt-lib.sh**
    - [x] Doing
    - [x] Backlog

## Features



## Informations
Christian Gößl
## Main Program


*make.sh*
```bash
noweb.py -Rtt-lib.sh tt-lib.sh.md > tt-lib.sh && echo 'tt-lib.sh' && date 

```


```bash
chmod u+x tt-lib.sh && ln -sf $(pwd)/tt-lib.sh ~/.local/bin/tt-lib.sh && echo 'fertig'
```

### tt-lib.sh

*tt-lib.sh*
```bash
#!/bin/bash
source config.sh
journalPage="$(config_get journalPage)"

#*cleanName}}

#*WikiMarkprev}}

#*Markdownprev}}

#*Timestamps}}

#*Wikiprev}}

#*get-extens}}

#*markdown-description-program}}

#*template-code}}

#*tex-description}}

#*ttex}}

#*file-description}}

#*ttpic}}

#*create-note}}

#*Markdown-description-file}}

#*ttvid}}

#*ttpdf}}

```
### cleanName

using ``cleanName`` function with the parameters as following
```bash
    cleanName p1
    p1 - filename
    output - text
```

*cleanName*
```bash
function cleanName(){
    echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g'|  sed 's/&/n/g' | sed 's/\///g' | sed 's/|//g' | sed 's/\[/(/g' | sed 's/\]/)/g' | sed 's/@/at/g' | sed 's/：/;/g' | sed 's/？/ß/g' | sed "s/|/;/g" | sed "s/·/;/g" | sed "s/💤/;/g" | sed "s/｜/-/g" | sed "s/?/ß/g" | sed "s/!/;/g" | sed "s/¦/;/g" | sed "s/⧸/-/g" | sed "s/~/-/g" | sed "s/—/-/g" | sed "s/#/;/g" | sed "s/!/;/g" | sed "s/\%/;/g"
}
```


### WikiMarkprev

using ``WikiMarkprev`` function with the parameters as following
```bash
    WikiMarkprev p1
    p1 - filename
    output - text
```

*WikiMarkprev*
```bash
function WikiMarkprev(){
    echo "Content-Type: text/x-zim-wiki"
    echo "Wiki-Format: zim 0.6"
    echo "# $1 "
}
```


### Markdownprev

using ``Markdownprev`` function with the parameters as following
```bash
    Markdownprev p1
    p1 - filename
    output - text
```

*Markdownprev*
```bash
function Markdownprev(){
    echo "# $1 "
}
```


### Timestamps

using ``Timestamps`` function with the parameters as following
```bash
    Timestamps p1 p2 p3
    p1 - folder
    p2 - cleaned filename
    p3 - file folder 
    output - text
```

*Timestamps*
```bash
function Timestamps(){
    echo "Text date: $(date +"%Y-%m-%d") Modi date: $(date +"%Y-%m-%d" -r "$1"/"$3"/"$2")"
}
```
echo "Text date: $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]") Modi date: $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]" -r "$1"/"$3"/"$2")"


### Wikiprev

using ``Wikiprev`` function with the parameters as following
```bash
    Wikiprev p1
    p1 - title or cleaned File
    output - text
```

*Wikiprev*
```bash
function Wikiprev(){
    echo "Content-Type: text/x-zim-wiki"
    echo "Wiki-Format: zim 0.6"
    echo "====== $1 ======"
}
```

### get-extens function - Get extension of file

the list of language names are saved in the config file under the variable ``langName``

using ``get-extens`` function with the parameters as following
```bash
    get-extens p1
    p1 - programming language name
    output - extension of file
```

*get-extens*
```bash
function get-extens(){
    langname=$1
    case ${langname} in
        cpp) extens="cpp"
            ;;
        python) extens="py"
            ;;
        julia) extens="jl"
            ;;
        html) extens="html"
            ;;
        css) extens="css"
            ;;
        javascript) extens="js"
            ;;
        bash) extens="sh"
            ;;
        lua) extens="lua"
            ;;
        plantuml) extens="plantuml" langname="pl"
            ;;
        typst) extens="typ"
            ;;
        gnuplot) extens="plt"
            ;;
        mermaid) extens="mmd"
            ;;
        *) extens="${langname}"
            ;;
    esac
    echo "${extens}"
}
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
    output - text
```

*file-description*
```bash
function file-description(){
    local folder=$1
    local File=$2
    local tags=$3
    local source=$4
    local additiontext=$5
    local picture=$6
    local folderSwitch=$7
    local fileFolder=
    local extens=${File##*.}
    if [[ ! $folderSwitch == "" ]]
    then
        local Filename=${File%.*}
        fileFolder=$Filename
        mkdir -p "$folder"/"$fileFolder"
        mv "$folder"/"$File" "$folder"/"$fileFolder"/"$File"
        mv "$folder"/"$fileFolder" "$folder"/"$File"
        fileFolder="$fileFolder.$extens"
    fi
    Wikiprev "$File"
    Timestamps "$folder" "$File" "$fileFolder"
    echo "$tags"
    if [[ ! $folderSwitch == "" ]]
    then
        echo "**[[./$File]]**"
    else
        echo "**[[../$File]]**"
    fi
    if [[ ! $picture == "" ]]
    then
        if [[ ! $folderSwitch == "" ]]
        then
            echo "{{./$File.avif?width=500}}"
        elif [[ jpg == $extens || PNG == $extens || JPEG == $extens || png == $extens || webp == $extens || jpeg == $extens || avif == $extens ]]
        then
            echo "{{../${File%.*}.avif?width=500}}"
        else
            echo "{{../$File.avif?width=500}}"
        fi
    fi
    echo -e "$source\n$additiontext\n"
}
```

### Markdown description file

using ``Markdown-description-file`` function with the parameters as following
```bash
    Markdown-description-file p1 p2 p3 p4 p5
    p1 - folder
    p2 - cleaned filename
    p3 - tags
    p4 - source
    p5 - additiontext
    output - text
```

*Markdown-description-file*
```bash
function Markdown-description-file(){
    Markdownprev "$1" "$2"
    #echo "Text creation time: [%Y-%m-%d]($(date +"$journalPage/%Y/%m/%d")) Modification time: [%Y-%m-%d]($(date +"$journalPage/%Y/%m/%d" -r "$File"))"
    echo "Text creation time: $(date +"%Y-%m-%d") Modification time: $(date +"%Y-%m-%d")"
    echo "$3"
    echo "**["$2"]] **"
    echo -e "$4\n$5\n"
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
    output - text
```

*create-note*
```bash
function create-note(){
    local folder=$1
    local title=$2
    local File=$(cleanName "$title")
    mkdir -p "${folder}"/"${File}"
    Wikiprev "$title"
    echo -e "$3"
    echo -e "$4\n$5\n"
    echo -e "==== Journal ====\n"
    #echo -e "=== $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]") ==="
    echo -e "=== $(date +"%Y-%m-%d") ==="
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
    output - text
```

*ttpic*
```bash
function ttpic(){
    local File=$(cleanName "$2")
    file-description "$1" "$File" "@BILD $3" "$4" "$5" "yes"
}
```

### ttvid

using ``ttvid`` function with the parameters as following
```bash
    ttvid p1 p2 p3 p4 p5 p6 p7 p8
    p1 - folder
    p2 - video - file
    p3 - tags
    p4 - source
    p5 - additiontext
    p6 - video not cleaned filename
    p7 - folder switch
    p8 - Download switch
    output - text
```

*ttvid*
```bash
function ttvid(){
    local folder=$1
    local File=$2
    local tags=$3
    local source=$4
    local additiontext="$5"
    local ofile=$6
    local folderSwitch=$7
    local downloadSwitch=$8
    local name=${File%.*}
    local extens=${File##*.}
    local oname=${ofile%.*}
    if [[ ! $folderSwitch == "" ]]
    then
        local fileFolder="$folder"/"$File"
    else
        local fileFolder="$folder"
    fi
    if [[ ! $downloadSwitch == "" ]]
    then
        additiontext="$(yt-dlp --get-description ${source})"
        file-description "$folder" "$File" "@VIDEO $tags" "$source" "$additiontext" "pic" "$folderSwitch"
        yt-dlp -q --sub-langs "en,de" --write-sub --write-thumbnail --write-auto-sub --sub-format "vtt" --skip-download -i ${source} -o "$folder/%(title)s.%(ext)s"
        mv "$folder"/"$oname".en.vtt "$fileFolder"/"$name".en.vtt
        mv "$folder"/"$oname".de.vtt "$fileFolder"/"$name".de.vtt
        convert "$folder"/"$oname".jpg "$fileFolder"/"$File".avif
        convert "$folder"/"$oname".jpeg "$fileFolder"/"$File".avif
        convert "$folder"/"$oname".webp "$fileFolder"/"$File".avif
        convert "$folder"/"$oname".png "$fileFolder"/"$File".avif
        rm "$folder"/"$oname".webp
        rm "$folder"/"$oname".jpg
        rm "$folder"/"$oname".jpeg
        rm "$folder"/"$oname".png
        local subtitlefile1="$name".en.vtt
        local subtitlefile2="$name".de.vtt
    else
		file-description "$folder" "$File" "@VIDEO $tags" "$source" "$additiontext" "pic" "$folderSwitch"
		# cat the old text file to the new one, then we do not need the ttvidc script
		cat "$folder"/"${oname}".txt
		rm "$folder"/"${oname}".txt
		ffmpeg -loglevel quiet -ss 2 -i "$fileFolder"/"$File"  -t 1 -f image2 "$folder"/"$File".png
        convert "$folder"/"$File".png -resize 1200x1200 "$fileFolder"/"$File".avif
		rm "$folder"/"$File".png
        ffmpeg -i "$folder"/"${oname}".srt "$fileFolder"/"${name}".vtt
        mv "$folder"/"${oname}".ttml "$fileFolder"/"${name}".ttml
        rm "$folder"/"${name}".srt
        local subtitlefile1=${name}.vtt
        local subtitlefile2=${name}.ttml
    fi

	echo -e "\n*$subtitlefile1*"
	echo -e "\`\`\`bash"
	cat "$fileFolder"/"$subtitlefile1"
	echo -e "\`\`\`"
	echo -e "\n*$subtitlefile2*"
	echo -e "\`\`\`bash"
	cat "$fileFolder"/"$subtitlefile2"
	echo -e "\`\`\`"
	echo -e "\n*make.sh*"
	echo -e "\`\`\`bash"
	echo -e "noweb.py -R$subtitlefile1 $File.md > $subtitlefile1 \nnoweb.py -R$subtitlefile2 $File.md > $subtitlefile2 \n echo '$File' && date \n\`\`\`\n\n"
}
```

### ttpdf

using ``ttpdf`` function with the parameters as following
```bash
    ttpdf p1 p2 p3 p4 p5
    p1 - folder
    p2 - file - pdf
    p3 - tags
    p4 - source
    p5 - additiontext
    p6 - folder switch
    output - text
```

*ttpdf*
```bash
function ttpdf(){
    local folder=$1
    local File=$(cleanName "$2")
    local tags=$3
    local source=$4
    local additiontext=$5
    local folderSwitch=$6
    local name=${File%.*}
    local extens=${File##*.}
    if [[ ! $folderSwitch == "" ]]
    then
        local fileFolder="$folder"/"$File"
    else
        local fileFolder="$folder"
    fi
    file-description "$folder" "$File" "@Document $tags" "$source" "$additiontext" "pic" "$folderSwitch"

    pdftoppm -png -singlefile "$fileFolder"/"$File" "$fileFolder"/"$File"
    convert "$fileFolder"/"$File".png -resize 1200x1200 "$fileFolder"/"$File".avif
    rm "$fileFolder"/"$File".png
    pdfinfo "$fileFolder"/"$File" | grep Pages
    echo -e "\n"
    pdftotext -nopgbrk -enc UTF-8 -f 1 -l 1 "$fileFolder"/"$File" -
}
```


### Code template function

using ``template-code`` function with the parameters as following
```bash
    template-code p1 p2 p3 p4
    p1 - folder
    p2 - file
    p3 - output file
    p4 - switchCode
    output - text
```

*template-code*
```bash
function template-code(){
    local folder=$1
    local File=$(cleanName "$2")
    local outFile=$(cleanName "$3")
    local switchCode=$4
    if [[ $outFile == "" ]]
    then
        outFile=${File}
    fi
    #local tags=$3
    #local source=$4
    #local additiontext=$5
    local Filename=${File%.*}
    local extens=${File##*.}
    local outFilename=${outFile%.*}
    local outextens=${outFile##*.}
    if [[ ! $switchCode == "" ]]
    then
        #touch "$folder"/${File}
        outFile=${outFilename}
        codeHead="*run code*"
    else
        #touch "$folder"/${outFile}
        codeHead="*make.sh*"
    fi
    if  [[ $extens == "plantuml" || $extens == "plt" || $extens == "mmd" ]]
    then
        echo -e "{{./${Filename}.png?width=500}}"
	fi
    echo -e " \n## ${extens} code\n\n"
    echo -e "$codeHead"
    echo -e "\`\`\`bash"
    case ${extens} in
        plantuml)
            mkdir -p "${outFile}"
            echo -e "noweb.py -R${Filename}.${extens} ${outFile}.md > "${outFile}"/${Filename}.${extens} && plantuml "${outFile}"/${Filename}.${extens} && echo '${Filename}.${extens}' && date && gwenview "${outFile}"/${Filename}.png 2>/dev/null \n\`\`\`"
            ;;
        typst) 
            echo -e "noweb.py -R${Filename}.${extens} ${outFile}.md > ${Filename}.${extens} && typst compile --format pdf ${Filename}.${extens} && echo '${Filename}.${extens}' && date && xournalpp ${Filename}.pdf 2>/dev/null & \n\`\`\`"
            ;;
        plt) 
            echo -e "noweb.py -R${Filename}.${extens} ${outFile}.md > "${outFile}"/${Filename}.${extens} && gnuplot "${outFile}"/${Filename}.${extens} -p \n\`\`\`"
            ;;
        mmd) 
            echo -e "noweb.py -R${Filename}.${extens} ${outFile}.md > "${outFile}"/${Filename}.${extens} && mermaid-cli.sh "${outFile}"/${Filename}.${extens} && echo '${Filename}.${extens}' && date && gwenview "${outFile}"/${Filename}.png 2>/dev/null \n\`\`\`"
            ;;
        *) 
            echo -e "noweb.py -R${Filename}.${extens} ${outFile}.md > ${Filename}.${extens} && echo '${Filename}.${extens}' && date \n\`\`\`"
            echo -e "\n\n\`\`\`bash"
            echo -e "chmod u+x ${Filename}.${extens} && ln -sf \$(pwd)/${Filename}.${extens} ~/.local/bin/${Filename}.${extens} && echo 'fertig'\n\`\`\`"
            ;;
    esac
    echo -e "\n*${Filename}.${extens}*"
    echo -e "\`\`\`${langname}"
    case ${extens} in
        sh) 
            echo -e "#!/bin/bash"
            ;;
        plantuml) 
            echo -e "@startuml\n allowmixing\n"
            echo -e "@enduml"
            ;;
        mmd)
            echo "graph TD"
            echo "    accTitle: My title here"
            echo "    accDescr: My description here"
            echo "    A[Enter Chart Definition] --> B(Preview)"
            ;;
        plt) 
            echo "reset"
            echo "set grid"
            echo "#set yrange [:]"
            echo "#set xrange [:]"
            echo "set ylabel 'y'"
            echo "set xlabel 'x'"
            echo "#set logscale y"
            echo "set term png"
            echo "set output sprintf('"${outFile}"/${Filename}.png')"
            echo "plot  lt rgb 'blue'"
            echo "#plot "data.txt" using ($1):($2) title '1' lt rgb 'blue', "data.txt" using ($1):($3) title '2' lt rgb 'red', "data.txt" using ($1):($4) title '3' lt rgb 'green'"
            echo "set term qt"
            echo "replot"
            ;;
    esac
    echo -e "\n\`\`\`"
}
```

### markdown description program

using ``markdown-description-program`` function with the parameters as following
```bash
    markdown-description-program p1
    p1 - cleaned file
    output - text
```


*markdown-description-program*
```bash
function markdown-description-program(){
    local File=$1
    #local filename=${File%.*}
    #local foldertex=$3
    echo -e "===== ${File} ====="
    echo -e "# ${File}"
    #echo -e "Created [$(date +%Y-%m-%d)]()\n"
    echo -e "Created $(date +%Y-%m-%d)\n"
    echo -e "\n## Description"
    echo -e "\n## Journal"
    echo -e " - [x] Backlog"
    echo -e "    - [ ] "
    echo -e " - [x] Doing"
}
```

### tex description

using ``tex-description`` function with the parameters as following
```bash
    tex-description p1 p2 p3 p4 p5
    p1 - folder
    p2 - cleaned File
    p3 - tex folder
    p4 - additiontext
    p5 - insert more commands
    output - text
```


*tex-description*
```bash
function tex-description(){
    local folder="$1"
    local File="$2"
    local filename=${File%.*}
    local foldertex="$3"
    local additiontext="$4"
    local moreCommands="$5"
    echo -e "\n## Latex File\n"
    echo -e "*${File}*"
    echo -e "\`\`\`tex"
    cat "$folder"/"$foldertex"/"${File}" >> "$folder"/"$foldertex"/"${filename}".md
    echo -e "\n\`\`\`"
    echo -e "\n*make.sh*"
    echo -e "\`\`\`bash"
    if [[ ! $moreCommands == "" ]]
    then
        echo -e "$moreCommands"
    fi
    echo -e "noweb.py -R${File} ${filename}.md > ${File} && lualatex -interaction=nonstopmode -shell-escape ${File} && lualatex -interaction=nonstopmode -shell-escape ${File} && date && xdg-open ${filename}.pdf 2>/dev/null \n\`\`\`\n\n"
    sed -i "s/additiontext/$additiontext/g" "$folder"/"$foldertex"/"${filename}".md
    sed -i "s/additiontext/$additiontext/g" "$folder"/"$foldertex"/"${filename}".tex
}
```



### ttex

using ``ttex`` function with the parameters as following
```bash
    ttex p1 p2 p3
    p1 - folder
    p2 - cleaned file
    p3 - original file
    output - text
```

procedure
- input
- move to tex folder
- make note file
- make description file of tex file
    - input tex file

*ttex*
```bash
function ttex(){
    local folder=$1
    local File=$(basename "$2")
    local filename=${File%.*}
    local f=$(basename "$3" .tex)
    local foldertex="$filename"_tex
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
    mv "$filename".* "$folder"/"$foldertex"/

    create-note "$folder" "$foldertex" "@LATEX $tags" "" "[[./$filename.md]]\n[[./$filename.tex]]\n[[./$filename.pdf]]" >> "$folder/$foldertex".md

    markdown-description-program "${filename}" >> "$folder/$foldertex"/"${filename}".md

    tex-description "$folder" "${File}" "$foldertex" >> "$folder"/"$foldertex"/"${filename}".md

}

```
