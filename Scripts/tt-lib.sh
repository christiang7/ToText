#!/bin/bash
source config.sh
journalPage="$(config_get journalPage)"

function cleanName () {
    echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g'|  sed 's/&/n/g' | sed 's/\///g' | sed 's/|//g' | sed 's/\[/(/g' | sed 's/\]/)/g' | sed 's/@/at/g' | sed 's/：/;/g' | sed 's/？/ß/g' | sed "s/|/;/g" | sed "s/·/;/g" | sed "s/💤/;/g" | sed "s/｜/-/g" | sed "s/?/ß/g" | sed "s/!/;/g" | sed "s/¦/;/g" | sed "s/⧸/-/g" | sed "s/~/-/g"
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
    echo "Text date: $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]") Modi date: $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]" -r "$1"/"$3"/"$2")" >> "$1"/"$2".md
}

function Wikiprev(){
    echo "Content-Type: text/x-zim-wiki" >> "$1"/"$2".md
    echo "Wiki-Format: zim 0.6" >> "$1"/"$2".md
    echo "====== $3 ======" >> "$1"/"$2".md
}

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
        *) extens="${langname}"
            ;;
    esac
    echo "${extens}"
}

function markdown-description-program(){
    local folder=$1
    local File=$2
    #local filename=${File%.*}
    #local foldertex=$3
    echo -e "# ${File}" >> "$folder"/"${File}".md
    echo -e "Created [$(date +%Y-%m-%d)]()\n" >> "$folder"/"${File}".md
    echo -e "\n## Description" >> "$folder"/"${File}".md
    echo -e "\n## Journal" >> "$folder"/"${File}".md
    echo -e " - [X] Doing" >> "$folder"/"${File}".md
    echo -e " - [X] Backlog" >> "$folder"/"${File}".md
    echo -e "    - [ ] " >> "$folder"/"${File}".md
}

function program-template(){
    local folder=$1
    local File=$(cleanName "$2")
    local outFile=$(cleanName "$3")
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
    if [[ $outextens == "tex" ]]
    then
        touch "$folder"/${File}
        outFile=${outFilename}
        echo -e " \n## ${extens} program\n\n" >> "$folder"/"${outFile}".md
        echo -e "*run program*" >> "$folder"/"${outFile}".md
    else
        touch "$folder"/${outFile}
        echo -e " \n## ${extens} program\n\n" >> "$folder"/"${outFile}".md
        echo -e "*run-cell.sh*" >> "$folder"/"${outFile}".md
    fi
    echo -e "\`\`\`bash" >> "$folder"/"${outFile}".md
    if  [[ $extens == "plantuml" ]]
    then
        echo -e "noweb.py -R${Filename}.${extens} ${outFile}.md > ${Filename}.${extens} && plantuml ${Filename}.${extens} && echo '${Filename}.${extens}' && date && gwenview ${Filename}.png 2>/dev/null \n\`\`\`" >> "$folder"/"${outFile}".md
    elif [[ $extens == "typst" ]]
    then
        echo -e "noweb.py -R${Filename}.${extens} ${outFile}.md > ${Filename}.${extens} && typst compile --format pdf ${Filename}.${extens} && echo '${Filename}.${extens}' && date && xournalpp ${Filename}.pdf 2>/dev/null & \n\`\`\`" >> "$folder"/"${outFile}".md
    else
        echo -e "noweb.py -R${Filename}.${extens} ${outFile}.md > ${Filename}.${extens} && echo '${Filename}.${extens}' && date \n\`\`\`" >> "$folder"/"${outFile}".md
        echo -e "\n\n\`\`\`bash" >> "$folder"/"${outFile}".md
        echo -e "chmod u+x ${Filename}.${extens} && ln -sf \$(pwd)/${Filename}.${extens} ~/.local/bin/${Filename}.${extens} && echo 'fertig'\n \`\`\`" >> "$folder"/"${outFile}".md
    fi
        echo -e "\n*${Filename}.${extens}*" >> "$folder"/"${outFile}".md
        echo -e "\`\`\`${langname}" >> "$folder"/"${outFile}".md
    if  [[ $extens == "plantuml" ]]
    then
        echo -e "@startuml\n" >> "$folder"/"${outFile}".md
        echo -e "@enduml" >> "$folder"/"${outFile}".md
    elif [[ $extens == "sh" ]]
    then
        echo -e "#!/bin/bash" >> "$folder"/"${outFile}".md
    fi
    echo -e "\n" >> "$folder"/"${outFile}".md
    echo -e "\`\`\`" >> "$folder"/"${outFile}".md
}

function tex-description(){
    local folder=$1
    local File=$2
    local filename=${File%.*}
    local foldertex=$3
    local additiontext="$4"
    local moreCommands="$5"
    echo -e "\n## Latex File\n" >> "$folder"/"$foldertex"/"${filename}".md
    echo -e "*${File}*" >> "$folder"/"$foldertex"/"${filename}".md
    echo -e "\`\`\`tex" >> "$folder"/"$foldertex"/"${filename}".md
    cat "$folder"/"$foldertex"/"${File}" >> "$folder"/"$foldertex"/"${filename}".md
    sed -i "s/additiontext/$additiontext/g" "$folder"/"$foldertex"/"${filename}".md
    echo -e "\n\`\`\`" >> "$folder"/"$foldertex"/"${filename}".md
    echo -e "\n*run-cell.sh*" >> "$folder"/"$foldertex"/"${filename}".md
    echo -e "\`\`\`bash" >> "$folder"/"$foldertex"/"${filename}".md
    if [[ ! $moreCommands == "" ]]
    then
        echo -e "$moreCommands" >> "$folder"/"$foldertex"/"${filename}".md
    fi
    echo -e "noweb.py -R${File} ${filename}.md > ${File} && pdflatex -synctex=1 -interaction=nonstopmode -shell-escape ${File} && date && xdg-open ${filename}.pdf 2>/dev/null \n\`\`\`\n\n" >> "$folder"/"$foldertex"/"${filename}".md
}

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

    create-note "$folder" "$foldertex" "@LATEX $tags" "" "[[./$filename.md]]\n[[./$filename.tex]]\n[[./$filename.pdf]]"

    markdown-description-program "$folder/$foldertex" "${filename}.tex"

    tex-description "$folder" "${File}" "$foldertex"

}


function file-description(){
    local folder=$1
    local File=$2
    local tags=$3
    local source=$4
    local additiontext=$5
    local picture=$6
    local folderSwitch=$7
    local fileFolder=
    if [[ ! $folderSwitch == "" ]]
    then
        local extens=${File##*.}
        local Filename=${File%.*}
        fileFolder=$Filename
        mkdir -p "$folder"/"$fileFolder"
        mv "$folder"/"$File" "$folder"/"$fileFolder"/"$File"
        mv "$folder"/"$fileFolder" "$folder"/"$File"
        fileFolder="$fileFolder.$extens"
    fi
    Wikiprev "$folder" "$File" "$File"
    Timestamps "$folder" "$File" "$fileFolder"
    echo "$tags" >> "$folder"/"$File".md
    if [[ ! $folderSwitch == "" ]]
    then
        echo "**[[./$File]]**" >> "$folder"/"$File".md
    else
        echo "**[[../$File]]**" >> "$folder"/"$File".md
    fi
    if [[ ! $picture == "" ]]
    then
        if [[ ! $folderSwitch == "" ]]
        then
            echo "{{./$File.avif?width=500}}" >> "$folder"/"$File".md
        else
            echo "{{../$File.avif?width=500}}" >> "$folder"/"$File".md
        fi
    else
        echo "{{../$File?width=500}}" >> "$folder"/"$File".md
    fi
    echo -e "$source\n$additiontext\n" >> "$folder"/"$File".md
}

function ttpic(){
    local File=$(cleanName "$2")
    file-description "$1" "$File" "@BILD $3" "$4" "$5"
    #echo "{{../$File?width=500}}" >> "$1"/"$File".md
}

function create-note(){
    local folder=$1
    local title=$2
    local File=$(cleanName "$title")
    mkdir -p "${folder}"/"${File}"
    Wikiprev "$folder" "$File" "$title"
    echo -e "$3" >> "${folder}"/"${File}".md
    echo -e "$4\n$5\n" >> "${folder}"/"${File}".md
    echo -e "==== Journal ====\n" >> "${folder}"/"${File}".md
    echo -e "=== $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]") ===" >> "${folder}"/"${File}".md
}

function Markdown-file-description(){
    Markdownprev "$1" "$2"
    echo "Text creation time: [%Y-%m-%d]($(date +"$journalPage/%Y/%m/%d")) Modification time: [%Y-%m-%d]($(date +"$journalPage/%Y/%m/%d" -r "$File"))" >> "$1"/"$2".md
    echo "$3" >> "$1"/"$2".md
    echo "**["$2"]] **" >> "$1"/"$2".md
    echo -e "$4\n$5\n" >> "$1"/"$2".md
}

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
		# cat the old text file to the new one, then we do not need the vidc script
		cat "$folder"/"${oname}".txt >> "$folder"/"$File".md
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

	echo -e "\n*$subtitlefile1*" >> "$folder"/"$File".md
	echo -e "\`\`\`bash" >> "$folder"/"$File".md
	cat "$fileFolder"/"$subtitlefile1" >> "$folder"/"$File".md
	echo -e "\`\`\`" >> "$folder"/"$File".md
	echo -e "\n*$subtitlefile2*" >> "$folder"/"$File".md
	echo -e "\`\`\`bash" >> "$folder"/"$File".md
	cat "$fileFolder"/"$subtitlefile2" >> "$folder"/"$File".md
	echo -e "\`\`\`" >> "$folder"/"$File".md
	echo -e "\n*run-cell.sh*" >> "$folder"/"$File".md
	echo -e "\`\`\`bash" >> "$folder"/"$File".md
	echo -e "noweb.py -R$subtitlefile1 $File.md > $subtitlefile1 \nnoweb.py -R$subtitlefile2 $File.md > $subtitlefile2 \n echo '$File' && date \n\`\`\`\n\n" >> "$folder"/"$File".md
}

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
    pdfinfo "$fileFolder"/"$File" | grep Pages >> "$folder"/"$File".md
    echo -e "\n" >> "$folder"/"$File".md
    pdftotext -nopgbrk -enc UTF-8 -f 1 -l 1 "$fileFolder"/"$File" ->> "$folder"/"$File".md

}

